# 尤诺发布工程 · 2026-11-09

发布基线保留已加载的 18 组资源三件套以及 L60 F8 脚本。资源层保持文件名与字节内容，以保留容器覆盖次序。可选卡通层包含 AutoToon、RenoDX DevKit 和着色器。

| 路径（相对工程根） | 内容 |
| --- | --- |
| `Releases/Younuo-2026.11.09/` | ZIP、SHA-256、玩家说明和构建输入清单 |
| `Releases/Younuo-2026.11.09/Inputs/` | 初始 F8 配置与独立保存的默认配置文件 |
| `Tools/Release/build_younuo.py` | 校验锁定的输入并生成 ZIP |
| `Releases/Younuo-2026.11.09/Setup/Deploy.ps1` | 下载、校验、部署与卸载入口 |
| `Tools/Release/YounuoLauncher.cs` | 双击入口源码，安装和卸载共用此源码 |
| `Builds/AnimAlignment/L60_back_weapon_visibility/F8/` | 最新 F8 脚本和回归测试 |
| `Builds/AnimAlignment/L58_barefoot_runtime/` | 裸脚网格与 Cook 验证 |
| `Builds/AnimAlignment/L59_barefoot_loader/` | 裸脚网格加载器与 Cook 验证 |
| `Builds/YounuoToonInjection_v01/` | 可选渲染层的运行时文件和制作记录 |

## 重建

使用 Python 3.11 或更新版本。在工程根执行下列命令。脚本以自身所在位置定位工程，也可从其他工作目录调用。

```powershell
python Tools/Release/build_younuo.py
python Tools/Release/build_younuo.py --verify-only
```

`source-manifest.json` 的 `source` 相对工程根，`archive_path` 相对 ZIP 根，`install_path` 相对 `PBZ` 游戏根。构建校验每个输入的 SHA-256，输出发布清单时移除 `source`。发布脚本可在游戏未安装的机器上重建，只要工程中的锁定输入齐全。

部署程序先校验本包文件，再按固定版本和 SHA-256 下载所需前置。ReShade 取官方安装器中的 x64 文件，直接部署到 `platform/steam/dxgi.dll`。游戏目录中的 `YounuoInstallReceipt.json` 记录所装层和新装前置。卸载使用发布清单核对 Mod 文件，并用安装记录区分新装与已有前置。

游戏资产引用保留 `/Game/`、`/HuaShira/` 和 `/Script/` 等 Unreal 虚拟挂载路径。它们由引擎解析，与 Windows 盘符和 Steam 库目录无关。裸脚加载器通过 `/Game/YounuoAlignment_L58/` 解析随包网格。F8 和 AutoToon 在运行时从脚本所在目录定位同包文件。需要替换资产时，应在 UE 中维护这些挂载路径和依赖，再重新 Cook 和验收。

历史制作目录和备份留在原位供追溯。历史日志、旧命令中的本机路径和原始导出均未进入发布包。发布构建只读取清单中列出的工程相对路径。

## 发布验证

- 18 个 IoStore 容器通过 `retoc verify`。发布清单中的资源和运行组件与实机文件逐一比对 SHA-256，初始 F8 设置采用面板出厂值。
- 在带空格的另一套目录中重建并解压，按清单安装 71 个文件并逐一校验。F8 Lua 回归 39 项通过，F8 面板自检通过，AutoToon 能从新目录找到随包挂载程序。
- 一键部署在独立目录完成了卡通版干净安装，自动下载了四项前置。移走一份资源并修改 F8 配置后，卸载报告一项缺失、备份了配置，清理了 83 个文件，保留了移走的文件和同目录无关文件。
- 实机移出原有资源及前置后，使用同一份发布包重新部署并从 Steam 启动。进入场景后确认 F8 面板运行、裸脚修正生效、RenoDX 自动挂载成功。
