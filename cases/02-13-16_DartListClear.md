# Dart Growable List + Clear Leak (02-13-16)

**Author**: Kenneth Endfinger<br/>
**Area**: Dart<br/>
**Source**: Dart VM<br/>
**Priority**: High

## Information

**Dart VM Version**: `Dart VM version: 1.14.2 (Tue Feb  9 15:10:44 2016) on "macos_x64"`

## Description

Growable lists do not shrink the buffer when `clear()` is called.
This means that if I allocate 1 million lists, each with 2000 elements,
and call `clear()`, memory is not actually cleared, as the buffer does not shrink.

## Steps to Reproduce

```
git clone https://github.com/IOT-DSA/reproductions.git tmp
cd tmp
pub get
dart --observe bin/02-13-16_DartIncreasedMemory.dart
```
