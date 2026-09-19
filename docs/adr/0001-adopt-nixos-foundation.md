# ADR 0001: Adoption of NixOS as the Immutable Appliance Foundation

* **Status:** Accepted
* **Date:** 2026-09-19

## Context
Initial prototyping utilized Ubuntu Server 24.04 LTS. Canonical's intellectual property policies legally define pre-configuring containers or altering network settings as a "modification," requiring formal paid OEM licensing. Furthermore, traditional mutable package managers (`apt`) risk leaving the system in an unbootable state if power is lost during a background update.

## Alternatives Considered
* Debian Stable
* Embedded Build Systems (Yocto/Buildroot)
* Container-Optimized OS (openSUSE MicroOS / Fedora Bootc)

## Decision Made
Exclusively adopt **NixOS** as an offline build system on Continuous Integration (CI) servers to generate bit-for-bit reproducible, static system images via purely functional Nix configurations.

## Consequences
* Grants total legal authority to strip NixOS branding and distribute "Unified OS" without OEM licensing fees.
* Eliminates "dependency hell" via atomic generation swaps.
* Provides a zero-cost local testing framework (\`nix-vm-test\`) for student developers.