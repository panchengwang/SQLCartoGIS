#include "ScGeometryIO.h"
#include <sstream>
#include <vector>
#include <cstdint>
#include <stdexcept>
#include <cctype>

ScGeometryIO::ScGeometryIO(QObject *parent)
    : QObject{parent}
{

}

QString ScGeometryIO::toWKB(OGRGeometry* geo)
{
    size_t len = geo->WkbSize();
    unsigned char* buf = new unsigned char[len];
    geo->exportToWkb(buf);
    QByteArray wkb((const char*)buf, len);
    delete [] buf;
    return QString(wkb.toHex());
}


// ///////////////////////////////////////////////////
// The following codes are generated by DeepSeek
const char kHexLookup[] = "0123456789ABCDEF";
static std::vector<uint8_t> HexStringToBinary(const std::string& hexStr) {
    // 检查输入有效性
    if (hexStr.length() % 2 != 0) {
        throw std::invalid_argument("Hex string length must be even.");
    }

    // 预分配结果空间
    std::vector<uint8_t> binaryData;
    binaryData.reserve(hexStr.length() / 2);

    // 遍历每两个字符转换为一个字节
    for (size_t i = 0; i < hexStr.length(); i += 2) {
        // 提取高四位和低四位字符
        char highChar = static_cast<char>(std::toupper(hexStr[i]));
        char lowChar = static_cast<char>(std::toupper(hexStr[i + 1]));

        // 查找字符对应的数值
        const char* highPos = std::strchr(kHexLookup, highChar);
        const char* lowPos = std::strchr(kHexLookup, lowChar);

        // 验证字符合法性
        if (highPos == nullptr || lowPos == nullptr) {
            throw std::invalid_argument("Invalid hex character in input.");
        }

        // 计算字节值
        uint8_t byteValue = static_cast<uint8_t>(
            (highPos - kHexLookup) << 4 | (lowPos - kHexLookup)
        );

        binaryData.push_back(byteValue);
    }

    return binaryData;
}


// ///////////////////////////////////////////////////
OGRGeometry* ScGeometryIO::fromWKB(const QString& wkbstr)
{
    std::vector<uint8_t> ewkb = HexStringToBinary(wkbstr.toStdString());

    // ///////////////////////////////////////////////////
    // The following codes are generated by DeepSeek
    if (ewkb.empty()) return nullptr;

    // --- 1. 解析字节顺序 ---
    const uint8_t byteOrder = ewkb[0];
    const bool isBigEndian = (byteOrder == 0); // 0=大端，1=小端

    // --- 2. 解析类型码 ---
    uint32_t typeCode;
    size_t offset = 1; // 跳过字节顺序标记

    // 读取类型码（4字节）
    if (isBigEndian) {
        typeCode = (ewkb[offset] << 24) | (ewkb[offset+1] << 16) | (ewkb[offset+2] << 8) | ewkb[offset+3];
    } else {
        typeCode = ewkb[offset] | (ewkb[offset+1] << 8) | (ewkb[offset+2] << 16) | (ewkb[offset+3] << 24);
    }
    offset += 4;

    // --- 3. 提取 SRID ---
    int srid = -1;
    const bool hasSrid = (typeCode & 0x20000000) != 0; // 检查 SRID 标志位
    if (hasSrid) {
        // 读取 SRID（4字节）
        if (isBigEndian) {
            srid = (ewkb[offset] << 24) | (ewkb[offset+1] << 16) | (ewkb[offset+2] << 8) | ewkb[offset+3];
        } else {
            srid = ewkb[offset] | (ewkb[offset+1] << 8) | (ewkb[offset+2] << 16) | (ewkb[offset+3] << 24);
        }
        offset += 4;
        typeCode &= ~0x20000000; // 清除 SRID 标志位
    }

    // --- 4. 处理高维坐标（Z/M）---
    bool hasZ = (typeCode & 0x80000000) != 0;
    bool hasM = (typeCode & 0x40000000) != 0;
    typeCode &= 0x0FFFFFFF; // 清除高维标志位

    // --- 5. 生成标准 WKB 字节流 ---
    std::vector<uint8_t> wkb;
    wkb.push_back(byteOrder); // 保留原始字节顺序

    // 写入调整后的类型码
    uint32_t ogrTypeCode = typeCode;
    if (hasZ) ogrTypeCode |= 0x80000000; // OGR 使用的高维标志位
    if (hasM) ogrTypeCode |= 0x40000000;

    for (int i = 0; i < 4; ++i) {
        if (isBigEndian) {
            wkb.push_back((ogrTypeCode >> (24 - i*8)) & 0xFF);
        } else {
            wkb.push_back((ogrTypeCode >> (i*8)) & 0xFF);
        }
    }

    // 复制剩余字节（坐标数据）
    wkb.insert(wkb.end(), ewkb.begin() + offset, ewkb.end());

    // --- 6. 创建几何对象 ---
    OGRGeometry* geom = nullptr;
    OGRGeometryFactory::createFromWkb(
        wkb.data(),          // WKB 数据指针
        nullptr,             // 默认空间参考（稍后设置 SRID）
        &geom,               // 输出的几何对象
        wkb.size()           // 数据长度
    );

    // --- 7. 设置 SRID ---
    if (geom && srid != -1) {
        OGRSpatialReference srs;
        if (srs.importFromEPSG(srid) == OGRERR_NONE) {
            geom->assignSpatialReference(&srs);
        }
    }

    return geom;
    // ///////////////////////////////////////////////////
}

QString ScGeometryIO::toWKT(OGRGeometry* geo)
{
    if(!geo){
        return "is null";
    }
    char* buf=NULL;
    geo->exportToWkt(&buf);
    QString ret(buf);
    CPLFree(buf);
    return ret;
}

OGRGeometry* ScGeometryIO::fromWKT(const QString& wkt)
{
    return NULL;
}
