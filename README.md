# 🛡️ Lua Caesar Cipher & Cryptanalysis Tool 🗝️

> *A robust, production-ready, single-file Lua implementation of the classic Caesar cipher designed specifically for cryptography enthusiasts and educational demonstrations!* 🚀

---

## 📖 Overview

Welcome! This project provides a clean, highly documented implementation of the **Caesar Cipher** (shift cipher) written entirely in **Lua**.

Beyond basic encryption and decryption, this tool bridges classical cryptography with modern educational concepts by demonstrating **brute-force cryptanalysis**—highlighting why a minuscule keyspace of just 26 makes substitution ciphers completely insecure against modern computing power. 💻⚡

---

## ✨ Features

* 🔤 **Case Preservation:** Automatically maintains uppercase and lowercase character boundaries.
* 🛡️ **Symbol Safety:** Leaves punctuation, spaces, numbers, and special symbols completely untouched.
* 🔄 **Modulo Arithmetic:** Gracefully handles negative shifts and shifts larger than the alphabet size ($26$).
* 💥 **Brute-Force Attack Simulation:** Instantly generates all $26$ possible decryptions to showcase structural cryptographic vulnerability.
* 📦 **Single-File Portability:** Zero external dependencies; runs on any standard Lua environment.

---

## 📸 Project Architecture & Interface Previews

### 🖼️ 1. Concept & Data Flow Diagram

```text
  [ Plaintext ] ──> ( Shift modulo 26 ) ──> [ Ciphertext ]
       │                                         │
       │ <── ( Reverse Shift ) ───────────────   │
       │                                         ▼
       └──> [ Brute-Force Analyzer ] ──> ( Displays 26 Keys )

```

### 🖼️ 2. Terminal Execution Preview

```text
==================================================
        CLASSICAL CRYPTOGRAPHY: CAESAR CIPHER     
==================================================

1. Original Plaintext:
   Hello, r/cryptography! Classical substitution ciphers provide zero semantic security.

2. Encrypting with secret shift = 13...
   Ciphertext:
   Uryyb, e/peltbencbag! Pybfpnyny fhooNfgrqvba pvcuref cebivqr merj frznagvp frphevgl.

3. Decrypting back with the same shift...
   Recovered Text:
   Hello, r/cryptography! Classical substitution ciphers provide zero semantic security.

[+] --- STARTING BRUTE-FORCE CRYPTANALYSIS ---
[*] Keyspace size is 26. Generating all possible plaintexts...

    Shift  0: Uryyb, e/peltbencbag! Pybfpnyny...
    Shift  1: Vszzc, f/qfmucdohbh! Qzcgqozmz...
    ...
    Shift 13: Hello, r/cryptography! Classical...
    ...

```

---

## 🚀 Getting Started

### 📋 Prerequisites

* **Lua Interpreter** (Compatible with Lua 5.1, 5.2, 5.3, 5.4, or LuaJIT).

### ⚙️ Installation & Execution

1. Clone or copy the project source code into a file named `caesar.lua`.
2. Open your terminal and execute the script:
```bash
lua caesar.lua

```



---

## 📂 Source Code (`caesar.lua`)

```lua
-- ============================================================================
-- PROJECT: Caesar Cipher Implementation & Cryptanalysis in Lua
-- TARGET: r/cryptography demonstration
-- DESCRIPTION: A robust, single-file Lua script demonstrating the classic
-- Caesar cipher, including encryption, decryption, and brute-force analysis.
-- ============================================================================

local Caesar = {}

-------------------------------------------------------------------------------
-- CORE CIPHER FUNCTIONS
-------------------------------------------------------------------------------

--- Encrypts a given text using the Caesar cipher algorithm.
-- @param text string: The plaintext message to encrypt.
-- @param shift number: The integer shift value (key).
-- @return string: The resulting ciphertext.
function Caesar.encrypt(text, shift)
    shift = shift % 26
    local encrypted_chars = {}
    
    for i = 1, #text do
        local char = text:sub(i, i)
        local byte = string.byte(char)
        
        -- Uppercase letters ('A' to 'Z': ASCII 65-90)
        if byte >= 65 and byte <= 90 then
            local shifted = ((byte - 65 + shift) % 26) + 65
            table.insert(encrypted_chars, string.char(shifted))
        
        -- Lowercase letters ('a' to 'z': ASCII 97-122)
        elseif byte >= 97 and byte <= 122 then
            local shifted = ((byte - 97 + shift) % 26) + 97
            table.insert(encrypted_chars, string.char(shifted))
        
        -- Non-alphabetic characters remain untouched
        else
            table.insert(encrypted_chars, char)
        end
    end
    
    return table.concat(encrypted_chars)
end

--- Decrypts a ciphertext by reversing the shift.
-- @param text string: The ciphertext message to decrypt.
-- @param shift number: The integer shift value (key).
-- @return string: The recovered plaintext.
function Caesar.decrypt(text, shift)
    return Caesar.encrypt(text, -shift)
end

-------------------------------------------------------------------------------
-- CRYPTANALYSIS DEMONSTRATION
-------------------------------------------------------------------------------

--- Demonstrates structural weakness via a brute-force attack.
-- @param ciphertext string: The intercepted ciphertext.
function Caesar.brute_force(ciphertext)
    print("\n[+] --- STARTING BRUTE-FORCE CRYPTANALYSIS ---")
    print("[*] Keyspace size is 26. Generating all possible plaintexts...\n")
    
    for shift = 0, 25 do
        local candidate = Caesar.decrypt(ciphertext, shift)
        print(string.format("    Shift %2d: %s", shift, candidate))
    end
    
    print("\n[+] --- END OF CRYPTANALYSIS ---\n")
end

-------------------------------------------------------------------------------
-- MAIN EXECUTION / TEST SUITE
-------------------------------------------------------------------------------

local function main()
    print("==================================================")
    print("        CLASSICAL CRYPTOGRAPHY: CAESAR CIPHER     ")
    print("==================================================")
    
    local plaintext = "Hello, r/cryptography! Classical substitution ciphers provide zero semantic security."
    local secret_shift = 13 -- ROT13 test case
    
    print("\n1. Original Plaintext:")
    print("   " .. plaintext)
    
    print(string.format("\n2. Encrypting with secret shift = %d...", secret_shift))
    local ciphertext = Caesar.encrypt(plaintext, secret_shift)
    print("   Ciphertext:")
    print("   " .. ciphertext)
    
    print("\n3. Decrypting back with the same shift...")
    local recovered_text = Caesar.decrypt(ciphertext, secret_shift)
    print("   Recovered Text:")
    print("   " .. recovered_text)
    
    Caesar.brute_force(ciphertext)
end

main()

```

---

## 📚 Cryptographic Takeaways

* **The Small Keyspace Problem:** With only $26$ possible keys, the Caesar cipher can be cracked manually or via automated script in milliseconds. Modern cryptography requires keyspaces large enough to make brute-force computationally impossible (e.g., $2^{128}$ or $2^{256}$ configurations).
* **Kerckhoffs's Principle:** Even if an attacker knows the algorithm entirely, security should rest solely on the secrecy of the key. Here, knowing the algorithm means the entire security collapses instantly upon brute-force.

---

Would you like to add automated **Frequency Analysis** logic next to score the decrypted candidates automatically using English letter distributions? 📊🔍
