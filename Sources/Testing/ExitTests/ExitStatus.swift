//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024–2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for Swift project authors
//

private import _TestingInternals

/// An enumeration describing possible status a process will report on exit.
///
/// You can convert an instance of this type to an instance of
/// ``ExitTest/Condition`` using ``ExitTest/Condition/init(_:)``. That value
/// can then be used to describe the condition under which an exit test is
/// expected to pass or fail by passing it to
/// ``expect(processExitsWith:observing:_:sourceLocation:performing:)`` or
/// ``require(processExitsWith:observing:_:sourceLocation:performing:)``.
///
/// @Metadata {
///   @Available(Swift, introduced: 6.2)
///   @Available(Xcode, introduced: 26.0)
/// }
#if SWT_NO_PROCESS_SPAWNING
@available(*, unavailable, message: "Exit tests are not available on this platform.")
#endif
public enum ExitStatus: Sendable {
  /// The process exited with the given exit code.
  ///
  /// - Parameters:
  ///   - exitCode: The exit code reported by the process.
  ///
  /// The C programming language defines two standard exit codes, `EXIT_SUCCESS`
  /// and `EXIT_FAILURE`. Platforms may additionally define their own
  /// non-standard exit codes:
  ///
  /// | Platform | Header |
  /// |-|-|
  /// | macOS | [`<stdlib.h>`](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/_Exit.3.html), [`<sysexits.h>`](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/sysexits.3.html) |
  /// | Linux | [`<stdlib.h>`](https://www.kernel.org/doc/man-pages/online/pages/man3/exit.3.html), [`<sysexits.h>`](https://www.kernel.org/doc/man-pages/online/pages/man3/sysexits.h.3head.html) |
  /// | FreeBSD | [`<stdlib.h>`](https://man.freebsd.org/cgi/man.cgi?exit(3)), [`<sysexits.h>`](https://man.freebsd.org/cgi/man.cgi?sysexits(3)) |
  /// | OpenBSD | [`<stdlib.h>`](https://man.openbsd.org/exit.3), [`<sysexits.h>`](https://man.openbsd.org/sysexits.3) |
  /// | Windows | [`<stdlib.h>`](https://learn.microsoft.com/en-us/cpp/c-runtime-library/exit-success-exit-failure) |
  ///
  /// @Comment {
  ///   See https://en.cppreference.com/w/c/program/EXIT_status for more
  ///   information about exit codes defined by the C standard.
  /// }
  ///
  /// On macOS, FreeBSD, OpenBSD, and Windows, the full exit code reported by
  /// the process is reported to the parent process. Linux and other POSIX-like
  /// systems may only reliably report the low unsigned 8 bits (0&ndash;255) of
  /// the exit code.
  ///
  /// @Metadata {
  ///   @Available(Swift, introduced: 6.2)
  ///   @Available(Xcode, introduced: 26.0)
  /// }
  case exitCode(_ exitCode: CInt)

  /// The process exited with the given signal.
  ///
  /// - Parameters:
  ///   - signal: The signal that caused the process to exit.
  ///
  /// The C programming language defines a number of standard signals. Platforms
  /// may additionally define their own non-standard signal codes:
  ///
  /// | Platform | Header |
  /// |-|-|
  /// | macOS | [`<signal.h>`](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/signal.3.html) |
  /// | Linux | [`<signal.h>`](https://www.kernel.org/doc/man-pages/online/pages/man7/signal.7.html) |
  /// | FreeBSD | [`<signal.h>`](https://man.freebsd.org/cgi/man.cgi?signal(3)) |
  /// | OpenBSD | [`<signal.h>`](https://man.openbsd.org/signal.3) |
  /// | Windows | [`<signal.h>`](https://learn.microsoft.com/en-us/cpp/c-runtime-library/signal-constants) |
  ///
  /// @Comment {
  ///   See https://en.cppreference.com/w/c/program/SIG_types for more
  ///   information about signals defined by the C standard.
  /// }
  ///
  /// @Metadata {
  ///   @Available(Swift, introduced: 6.2)
  ///   @Available(Xcode, introduced: 26.0)
  /// }
  case signal(_ signal: CInt)
}

// MARK: - Equatable

#if SWT_NO_PROCESS_SPAWNING
@available(*, unavailable, message: "Exit tests are not available on this platform.")
#endif
extension ExitStatus: Equatable {}

// MARK: - CustomStringConvertible
@_spi(Experimental)
#if SWT_NO_PROCESS_SPAWNING
@available(*, unavailable, message: "Exit tests are not available on this platform.")
#endif
extension ExitStatus: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .exitCode(exitCode):
      ".exitCode(\(exitCode))"
    case let .signal(signal):
      ".signal(\(signal))"
    }
  }
}
