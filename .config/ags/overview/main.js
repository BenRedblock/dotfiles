import { Widget } from "../imports.js";
import { SearchAndWindows } from "./overview.js";

export default () =>
  Widget.Window({
    name: "overview",
    exclusivity: "normal",
    keymode: "exclusive",
    visible: false,
    anchor: ["top"],
    layer: "overlay",
    child: Widget.Box({
      vertical: true,
      children: [SearchAndWindows()],
    }),
  });
