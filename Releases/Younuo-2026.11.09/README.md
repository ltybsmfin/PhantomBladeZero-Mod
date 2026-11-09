# 尤诺替换主角「魂」｜玩家安装指南

只想换成尤诺、调整物理或切换光脚，装 **01-Core**。想加上卡通渲染，再装 **02-Toon**。建议先让基础版正常运行，再加可选版。

## 一键安装和卸载

1. 退出游戏，把 ZIP **全部解压**，然后双击 `Install-Younuo.exe`。
2. 选中 Steam「管理 → 浏览本地文件」打开的游戏目录。输入 `1` 装基础版，输入 `2` 加装卡通渲染。
3. 程序会检查安装包和游戏目录，并从官方来源下载缺少的前置。卡通版还会检查 .NET Framework 及默认显卡的图形支持，并关闭 ReShade 首次教程及通知。前置与游戏程序一起装在游戏目录的 `platform/steam/`，包括 ReShade 的 `dxgi.dll`。部署完成后从 Steam 启动并读档，按 **F8**。
4. 要卸载，退出游戏后双击同一个解压目录里的 `Uninstall-Younuo.exe`，再选游戏目录。程序会逐项核对并列出缺失或改动过的文件，继续移除其余已安装文件。改动过的 Mod 文件会先备份到游戏目录的 `YounuoInstallBackup/`。如果其他 Mod 也在用前置，按 Enter 保留它们。

首次自动下载需要联网。如果电脑拦截运行程序或已有不同版本的前置，可以用下面的手动方法。游戏目录中若有其他版本的尤诺资源，请先按下文备份旧版。

## 1. 找到游戏目录

1. 退出游戏。若 F8 调节窗口还开着，也一起关闭。
2. 在 Steam 库右键《影之刃零》，选「管理 → 浏览本地文件」。打开的文件夹就是本指南说的**游戏目录**。打开后应能直接看到 `ProjectPBZ` 和 `platform` 两个文件夹。
3. 将 Mod ZIP **全部解压到单独的文件夹**。打开解压后的文件夹，应能看到 `01-Core` 和 `02-Toon`。下文的目标位置都从游戏目录开始算。

如果装过旧版尤诺，先把游戏里的 `ProjectPBZ/Content/Paks/~mods/` 下旧的 `zzz_Younuo_` 开头文件移到游戏目录外备份。旧 F8 设置在 `platform/steam/ue4ss/Mods/YounuoPhysicsPanel/settings.txt`，想保留就先备份这份文件。

## 2. 装基础版

**先装两个前置。** 前置需要另行下载。已经装好并能正常使用的可以跳过。

1. **资源加载前置**让游戏读到角色替换文件。下载适用于《影之刃零》的 UniversalSigBypasser，解压后将 `UniversalSigBypasser.asi` 和随附的 64 位 `dsound.dll` 放进游戏的 `platform/steam/`，和 `PBZ.exe` 放在一起。[UniversalSigBypasser 下载页](https://github.com/rm-NoobInCoding/UniversalSigBypasser/releases)
2. **《影之刃零》专用 UE4SS**负责打开 F8。下载 `phantombladezero_ue4ss_v3.0.1-1183-gcdbc0b66-r2.zip`。解压后把里面的 `dwmapi.dll` 和整个 `ue4ss` 文件夹放到游戏的 `platform/steam/`。已经使用其他 UE4SS 模组时，先确认前置版本再替换。[专用 UE4SS 下载页](https://github.com/KintaroModding/ue4ss/releases/tag/v3.0.1-1183-gcdbc0b66-r2)

**再复制 Mod 文件。** 打开解压后的 `01-Core`，选中里面的 **`ProjectPBZ` 和 `platform` 两个文件夹**，复制到游戏目录。Windows 询问是否合并同名文件夹时，选择合并。打开游戏目录时，仍应直接看到 `ProjectPBZ` 和 `platform`。

复制完可按下表检查。也可以只按表复制所需文件。

| 从解压包里找 | 放到游戏目录下 |
| --- | --- |
| `01-Core/ProjectPBZ/Content/Paks/~mods/` 里的所有 `.pak`、`.utoc`、`.ucas` 文件 | `ProjectPBZ/Content/Paks/~mods/`。如果没有 `~mods`，就创建一个。18 组三件套全部复制，保留文件名。 |
| `01-Core/platform/steam/ue4ss/Mods/` 里的整个 `YounuoPhysicsPanel` 文件夹 | `platform/steam/ue4ss/Mods/`。复制后打开 `YounuoPhysicsPanel`，应该直接看到 `YounuoPhysicsPanel.exe`、`enabled.txt` 和 `Scripts` 文件夹。 |

## 3. 进游戏怎么用

1. 从 Steam 启动游戏并读档。看到主角变成尤诺，就说明角色替换已载入。
2. 按 **F8** 打开「尤诺 · 角色与物理调节」。可以调头发、胸部和裙摆的摆幅，也能切换鞋子和背部武器显示。
3. **想光脚站平**，取消勾选「显示鞋子」，同时勾选「光脚姿态修正」。想穿回鞋子，就重新勾选「显示鞋子」。
4. 更改会自动保存，按 **Esc** 返回游戏。想把设置恢复到初始值，点「恢复默认」。笔记本或掌机可以用 `Fn` 组合键、外接键盘或按键映射发送 F8。

只需要角色替换时，资源文件和资源加载前置就够了。F8、裸脚切换和下面的卡通版需要 UE4SS。

## 4. 想用卡通渲染时再装

1. 下载并运行 **ReShade 6.7.3 Full Add-on** 安装器。在安装器里选游戏目录下的 `platform/steam/PBZ.exe`，再选 **DirectX 10/11/12**。效果包和预设可以跳过。装好后，`PBZ.exe` 旁边应有 `dxgi.dll`。如果原来就有 ReShade，先备份 `dxgi.dll` 和 `ReShade.ini`，再核对版本。[ReShade 6.7.3 Full Add-on 安装器](https://reshade.me/downloads/ReShade_Setup_6.7.3_Addon.exe)
2. 打开解压包的 `02-Toon`，把**里面的 `platform` 文件夹**复制到游戏目录并合并。按下表确认位置。
3. 游戏关闭时，双击游戏目录下 `platform/steam/HideReShadeNotifications.bat`，跳过首次教程并关闭 ReShade 的通知和统计显示。已有设置会先备份。然后从 Steam 启动游戏并读档，卡通渲染会自动挂载。

| 从解压包里找 | 放到游戏目录下 |
| --- | --- |
| `02-Toon/platform/steam/` 里的 `YounuoAttach.exe` 和 `renodx-devkit.addon64` | `platform/steam/`，和 `PBZ.exe` 同一层 |
| `02-Toon/platform/steam/` 里的 `HideReShadeNotifications.bat` 和 `HideReShadeNotifications.ps1` | `platform/steam/`，和 `PBZ.exe` 同一层。双击 `.bat` 即可。 |
| `02-Toon/platform/steam/` 里的整个 `renodx-dev` 文件夹 | `platform/steam/`。复制后应能在 `platform/steam/renodx-dev/live/` 看到 `0xCA4CA643.ps_6_6.hlsl`。 |
| `02-Toon/platform/steam/ue4ss/Mods/` 里的整个 `YounuoAutoToon` 文件夹 | `platform/steam/ue4ss/Mods/` |

ReShade 启动时仍可能短暂显示版本条，加载完成后会自行消失。可以按 **Home** 打开 ReShade 设置。卸载 Mod 时会保留 ReShade 设置，方便其他模组继续使用。

### 设备和环境

- **基础版**面向 Windows 10／11 x64 的 Steam 玩家。先确认原游戏能正常运行。CPU、内存、显卡和 SSD 要求见官方商店页。Windows x64 笔记本和掌机可照同一流程安装，各型号未逐一验证。SteamOS／Proton、Windows ARM64 和其他商店版也未验证。[Steam 官方配置](https://store.steampowered.com/app/4115450/Phantom_Blade_Zero/#sysreqs)
- **卡通版**还要求游戏使用 Direct3D 12，实际运行游戏的显卡和驱动支持 Shader Model 6.6。ReShade 安装器需要 .NET Framework 4.8 或兼容的更新版本。双显卡设备可在 Windows「设置 → 系统 → 显示 → 图形」里把 `PBZ.exe` 设为「高性能」。[ReShade 官方要求](https://reshade.me/) · [Microsoft Shader Model 说明](https://learn.microsoft.com/en-us/windows/win32/api/d3d12/ne-d3d12-d3d_shader_model) · [.NET Framework 4.8 运行时](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net48)

## 不熟悉前置安装？可以请 AI 带你操作

把这份说明发给你信任的 AI 助手，然后复制下面这段话。只会聊天的助手也可以告诉你每一步该点哪里。若助手能操作电脑，请它先列出会改哪些文件，由你确认后再执行。

> 我想给 Steam 版《影之刃零》安装尤诺 Mod。请根据这份安装说明，用鼠标操作的步骤带我找到游戏目录，检查已有的资源加载前置和《影之刃零》专用 UE4SS。我要用卡通渲染时，再帮我检查 ReShade Full Add-on。请用说明里的原作者下载页，告诉我应该下载哪个文件、解压到游戏目录下哪一层。若遇到同名文件，先告诉我如何备份。最后帮我核对目录，并告诉我进游戏按什么键。

## 遇到问题或想卸载

- **人物没替换**时，先确认 `~mods` 里直接放着 18 组三件套，以及 `dsound.dll` 和 `UniversalSigBypasser.asi` 在 `PBZ.exe` 旁边。其他主角替换、骨架或动作 Mod 可以先移出备份，排除冲突。
- **F8 没反应**时，检查 `YounuoPhysicsPanel` 是否放在 `ue4ss/Mods/` 下，并在 `platform/steam/ue4ss/UE4SS.log` 里找 `YounuoPhysicsPanel` 的启动记录。
- **卡通渲染没出现**时，在 `platform/steam/ReShade.log` 里找 `D3D12` 和 `RenoDX DevKit`，再在同目录的 `YounuoAttach.log` 里找 `toon takeover is live`。如果日志提示缺少 `dxcompiler.dll` 或 `dxil.dll`，从微软的 DXC 稳定版下载包里取同一版本 `bin/x64/` 下的这两个文件，放在 `PBZ.exe` 旁边。若提示缺少 `VCRUNTIME` 或 `MSVCP`，安装微软 x64 Visual C++ 运行库。[Microsoft DXC 下载页](https://github.com/microsoft/DirectXShaderCompiler/releases) · [Microsoft Visual C++ 运行库](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist/)
- **卸载**时，先退出游戏，再按上面两张表移走本包复制进去的文件。只想关掉卡通版，移走 `02-Toon` 对应的文件即可。前置可能由多个 Mod 共用，确认没有其他 Mod 使用时再卸载前置。

## 借物表

- 尤诺角色模型来源及版权归《鸣潮》／库洛游戏。Blender 渲染修复素材鸣谢 B 站、抖音 **@Mark42的铁镐**。
- 资源前置由 rm-NoobInCoding 和 ThirteenAG 提供。[UniversalSigBypasser](https://github.com/rm-NoobInCoding/UniversalSigBypasser) · [Ultimate ASI Loader](https://github.com/ThirteenAG/Ultimate-ASI-Loader)
- 脚本前置由 UE4SS 团队和《影之刃零》适配版维护者提供。[UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) · [PBZ 适配版](https://github.com/KintaroModding/ue4ss/releases/tag/v3.0.1-1183-gcdbc0b66-r2)
- ReShade 由 crosire 提供。可选层的 DevKit 基于 Carlos Lopez Jr. 的 RenoDX，随包附 MIT 许可。[ReShade](https://reshade.me/) · [RenoDX](https://github.com/clshortfuse/renodx)
