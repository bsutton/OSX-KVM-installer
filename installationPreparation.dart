#! /usr/bin/env dcli

import 'dart:io';
import 'package:dcli/dcli.dart';

/// dcli script generated by:
/// dcli create installationPreparation.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

class InstallationPreparation{
  static bool installDependencies(){
    bool result = true;
    try{
      'sudo apt-get install qemu uml-utilities virt-manager dmg2img git wget libguestfs-tools -y'
          .start(priviliged: true);
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }

  static bool cloneOSXKVM(){
    bool result = true;
    try{
      'git clone https://github.com/kholia/OSX-KVM.git'.start(priviliged: true, workingDirectory: HOME);
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }

  static bool fetchInstaller(){
    bool result = true;
    try{
      './fetch-macOS.py'.start(workingDirectory: '~/OSX-KVM');
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }

  static bool convertToIMG(){
    bool result = true;
    try{
      'dmg2img BaseSystem.dmg BaseSystem.img'.start(workingDirectory: '~/OSX-KVM');
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }
  static bool createHDD({@required int sizeGB}){
    bool result = true;
    try{
      'qemu-img create -f qcow2 mac_hdd_ng.img ${sizeGB.toString}G'.start(workingDirectory: '~/OSX-KVM');
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }

  static bool setupQuickNetworking(){
    bool result = true;
    try{
      'ip tuntap add dev tap0 mode tap'.start(priviliged: true, workingDirectory: '~/OSX-KVM');
      'ip link set tap0 up promisc on'.start(priviliged: true, workingDirectory: '~/OSX-KVM');
      'ip link set dev virbr0 up'.start(priviliged: true, workingDirectory: '~/OSX-KVM');
      'ip link set dev tap0 master virbr0'.start(priviliged: true, workingDirectory: '~/OSX-KVM');
    }
    on Exception catch(_){
      result = false;
    }
    return result;
  }
}