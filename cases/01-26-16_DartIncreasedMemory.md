# Dart Increased Memory Use (01-26-16)

**Author**: Kenneth Endfinger<br/>
**Area**: Broker/SDK

## Information

**Dart VM Version**: `1.14.0-dev.7.2 (Wed Jan 20 10:50:44 2016) on "macos_x64"`

## Description

Observatory shows somewhere around these memory statistics:

```
Main Isolate:
  New Generations: Using (0 to 32)MB of 32MB
  Old Generation: Around ~15 of 20MB
Main Isolate:
  New Generations: Using (0 to 32)MB of 32MB
  Old Generation: Around ~12 of 20MB
```

When reproduced on Mac with the Dart VM above, I am getting around 400MB of real memory usage.
Even with VM-related objects factored in, memory usage seems extremely high.

## Steps to Reproduce

```
git clone https://github.com/IOT-DSA/reproductions.git tmp
cd tmp
pub get
dart --observe bin/01-26-16_DartIncreasedMemory.dart
```
