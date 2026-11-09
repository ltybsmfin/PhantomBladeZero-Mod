"""Build the Younuo distribution from pinned project-relative inputs."""

import argparse
from collections import defaultdict
from hashlib import file_digest, sha256
import json
from pathlib import Path, PurePosixPath
import re
from shutil import copyfileobj
from tempfile import NamedTemporaryFile
from zipfile import ZIP_DEFLATED, ZipFile, ZipInfo


ROOT = Path(__file__).resolve().parents[2]
RELEASE = ROOT / 'Releases/Younuo-2026.11.09'
ZIP_NAME = 'Younuo-PBZ-2026.11.09.zip'
ASSET_EXTENSIONS = {'.pak', '.utoc', '.ucas'}
MODS = 'ProjectPBZ/Content/Paks/~mods/'


def require(condition, message):
    if not condition:
        raise ValueError(message)


def relative(value):
    path = PurePosixPath(value)
    require(value == path.as_posix() and not path.is_absolute() and path.parts
            and '..' not in path.parts and not any(c in value for c in ':\\\r\n'),
            f'Invalid relative path: {value}')
    return path


def validate_inputs(spec):
    files, containers = {}, defaultdict(set)
    for entry in spec['files']:
        archive_path = relative(entry['archive_path'])
        install_path = entry.get('install_path')
        if install_path:
            relative(install_path)
            require(archive_path.as_posix() == f'{entry["layer"]}/{install_path}', archive_path)
        source = (ROOT / relative(entry['source'])).resolve(strict=True)
        require(source.is_relative_to(ROOT), f'Input escaped project: {entry["source"]}')
        with source.open('rb') as stream:
            require(file_digest(stream, 'sha256').hexdigest() == entry['sha256'],
                    f'Input hash changed: {entry["source"]}')
        require(source.stat().st_size == entry['size'], f'Input size changed: {source.name}')
        require(archive_path.as_posix().casefold() not in files, f'Duplicate path: {archive_path}')
        files[archive_path.as_posix().casefold()] = (archive_path.as_posix(), source, entry['sha256'])
        if install_path and install_path.startswith(MODS):
            require(archive_path.name.startswith('zzz_Younuo_') and archive_path.suffix in ASSET_EXTENSIONS,
                    f'Unexpected asset payload: {archive_path}')
            containers[archive_path.stem].add(archive_path.suffix)
        if source.suffix in {'.lua', '.hlsl', '.txt'}:
            content = source.read_text(encoding='utf-8-sig')
            require(not re.search(r'(?i)\b[a-z]:[\\/]', content), f'Local drive path: {source.name}')
            if source.suffix == '.hlsl':
                require(not re.search(r'^\s*#\s*include\b', content, re.M),
                        f'Unexpected external shader include: {source.name}')
    require(set(containers) == set(spec['containers']) and len(containers) == len(spec['containers'])
            and all(parts == ASSET_EXTENSIONS for parts in containers.values()),
            'Missing or incomplete game containers')
    return sorted(files.values())


def zip_entry(name):
    entry = ZipInfo(name, date_time=(2026, 11, 9, 0, 0, 0))
    entry.compress_type = ZIP_DEFLATED
    return entry


def verify(archive, files):
    with ZipFile(archive) as package:
        require(package.namelist() == [name for name, _, _ in files] + ['SHA256SUMS.txt'],
                'Unexpected files in ZIP')
        checksums = ''
        for name, _, expected in files:
            with package.open(name) as stream:
                require(file_digest(stream, 'sha256').hexdigest() == expected, f'ZIP mismatch: {name}')
            checksums += f'{expected}  {name}\n'
        require(package.read('SHA256SUMS.txt') == checksums.encode('utf-8'), 'ZIP checksums differ')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--verify-only', action='store_true', help='Check the existing ZIP against the release inputs')
    args = parser.parse_args()
    spec = json.loads((RELEASE / 'source-manifest.json').read_text(encoding='utf-8'))
    files = validate_inputs(spec)
    public = {key: value for key, value in spec.items() if key != 'files'}
    public['files'] = [{key: value for key, value in entry.items() if key != 'source'} for entry in spec['files']]
    manifest = (json.dumps(public, ensure_ascii=False, indent=2) + '\n').encode('utf-8')
    files.append(('manifest.json', manifest, sha256(manifest).hexdigest()))
    archive = RELEASE / ZIP_NAME
    if not args.verify_only:
        with NamedTemporaryFile(dir=RELEASE, suffix='.zip.tmp', delete=False) as temp:
            pending = Path(temp.name)
        try:
            with ZipFile(pending, 'w', compression=ZIP_DEFLATED) as package:
                for name, source, _ in files:
                    if isinstance(source, Path):
                        entry = zip_entry(name)
                        entry.file_size = source.stat().st_size
                        with source.open('rb') as input_file, package.open(entry, 'w') as output_file:
                            copyfileobj(input_file, output_file, length=1024 * 1024)
                    else:
                        package.writestr(zip_entry(name), source)
                package.writestr(zip_entry('SHA256SUMS.txt'), ''.join(
                    f'{expected}  {name}\n' for name, _, expected in files).encode('utf-8'))
            verify(pending, files)
            pending.replace(archive)
        finally:
            pending.unlink(missing_ok=True)
    else:
        verify(archive, files)
    with archive.open('rb') as stream:
        digest = file_digest(stream, 'sha256').hexdigest()
    if not args.verify_only:
        (RELEASE / (ZIP_NAME + '.sha256')).write_text(f'{digest}  {ZIP_NAME}\n', encoding='ascii')
    print(f'Verified {len(files)} entries plus SHA256SUMS.txt, {len(spec["containers"])} containers')
    print(f'{ZIP_NAME}: {archive.stat().st_size:,} bytes, SHA-256 {digest}')


if __name__ == '__main__':
    main()
