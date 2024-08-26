import 'dart:typed_data';

import 'package:print_cmd/tsc/label_command.dart';

class LabelHelper {
  static Uint8List build4030Tspl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(40, 30);
    cmd.addText("#${no}", offsetX, offsetY, font: "SS24.BF", scale: 2);
    cmd.addText(separator * 24, offsetX, offsetY + 50);
    cmd.addText(name, offsetX, offsetY + 80, font: "TSS24.BF2", scale: 2);
    cmd.addText(specification, offsetX, offsetY + 140, font: "TSS24.BF2");
    cmd.addText(separator * 24, offsetX, offsetY + 170);
    cmd.addText(date, offsetX, offsetY + 190, font: "TSS24.BF2");
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build6040Tspl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(60, 40);
    cmd.addText("#${no}", offsetX, offsetY, font: "SS24.BF", scale: 2);
    cmd.addText(separator * 36, offsetX, offsetY + 50);
    cmd.addText(name, offsetX, offsetY + 80, font: "TSS24.BF2", scale: 2);
    cmd.addText(specification, offsetX, offsetY + 140, font: "TSS24.BF2");
    cmd.addText(separator * 36, offsetX, offsetY + 230);
    cmd.addText(date, offsetX, offsetY + 250, font: "TSS24.BF2");
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build4030Cpcl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 200 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr('TEXT 4 1 $offsetX ${offsetY + 0} #$no\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 60} ${separator * 18}\r\n');
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 90} $name\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 130} $specification\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 155} ${separator * 18}\r\n');
    cmd.addStr('TEXT 5 0 $offsetX ${offsetY + 175} $date\r\n');
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static Uint8List build6040Cpcl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 300 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr('TEXT 4 1 $offsetX ${offsetY + 0} #$no\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 60} ${separator * 32}\r\n');
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 90} $name\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 140} $specification\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 230} ${separator * 32}\r\n');
    cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 250} $date\r\n');
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static Uint8List build4030TsplRetail({
    required String shopName,
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(40, 30);
    cmd.addText(shopName, offsetX + 10, offsetY + 10,
        font: "TSS24.BF2", scale: shopName.length > 6 ? 1 : 2);
    cmd.addText('品名：$name', offsetX + 10, offsetY + 60, font: "TSS24.BF2");
    cmd.addText('规格：$spec', offsetX + 10, offsetY + 90, font: "TSS24.BF2");
    cmd.addText('销售价：$sellPrice元', offsetX + 10, offsetY + 120,
        font: "TSS24.BF2");
    // cmd.addText('条形码：', offsetX + 10, offsetY + 165, font: "TSS24.BF2");
    cmd.addBarcode(barcode, 10 + offsetX, 150 + offsetY, 56, false);
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build4030CpclRetail({
    required String shopName,
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 200 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 4 0 ${offsetX + 10} ${offsetY + 10} $shopName\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 50} 品名：$name\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 85} 规格：$spec\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 120} 销售价：$sellPrice元\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    // cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 165} 条形码：\r\n');
    cmd.addStr('BARCODE-W 1\r\n');
    cmd.addStr(
        "BARCODE 128 1 0 50 ${10 + offsetX} ${155 + offsetY} $barcode\r\n");
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }
}
