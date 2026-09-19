# TensorFoundry for Zed

Two low-glare dark themes built for long sessions in Zed. Both use the TensorFoundry palette—forge orange, violet, and cyan—with softened syntax colours to keep code structure clear without visual noise.

- **TensorFoundry Dark** uses soothing graphite and midnight-slate surfaces with clear separation between editor, navigation, tabs, and panels.
- **TensorFoundry Dark Night** is the deeper near-black variant for distraction-free work.

## Install for development

1. Open Zed's command palette.
2. Run `zed: install dev extension`.
3. Select this directory.
4. Run `theme selector: toggle` and choose **TensorFoundry Dark** or **TensorFoundry Dark Night**.

To use only the theme files, copy `themes/tensorfoundry-dark.json` and `themes/tensorfoundry-dark-night.json` into `~/.config/zed/themes/`, then select either variant from Zed's theme selector.

## Palette

| Role | Colour |
| --- | --- |
| Dark editor | `#191D27` |
| Dark surface | `#191E29` |
| Dark Night editor | `#0C0C0F` |
| Dark editor text | `#DADCE3` |
| Dark Night editor text | `#D8D7DE` |
| Forge orange | `#FF7A00` |
| Violet | `#A33CFF` |
| Cyan | `#3AD6FF` |

### Syntax roles

| Role | Colour |
| --- | --- |
| Keywords and directives | `#E59B75` muted ember |
| Functions and methods | `#E7C27D` foundry gold |
| Parameters | `#D3A3BA` dusty rose |
| Constants and numbers | `#C9A7D8` soft orchid |
| Attributes and decorators | `#7EC9D4` oxidised cyan |
| Properties and members | `#8FC7B5` mineral mint |
| Types and constructors | `#B6A0E0` forge violet |
| Strings | `#A9C77D` tempered sage |
| Operators | `#C78569` subdued copper |

The palette groups code by meaning: warm tones describe control and action, violet describes structure, rose marks inputs, cool mineral tones identify metadata and member data, and green is reserved for literal content. The saturated TensorFoundry orange (`#FF7A00`) remains reserved for focus borders and other strong interface signals.

## License

MIT
