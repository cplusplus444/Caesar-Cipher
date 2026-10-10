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
    -- Normalize the shift to a 0-25 range using modulo arithmetic.
    -- This handles negative shifts and shifts greater than 26 gracefully.
    shift = shift % 26
    local encrypted_chars = {}
    
    -- Iterate through each character of the string by index
    for i = 1, #text do
        local char = text:sub(i, i)
        local byte = string.byte(char)
        
        -- Check for Uppercase letters (ASCII range 65-90: 'A' to 'Z')
        if byte >= 65 and byte <= 90 then
            -- Formula: (x - base + shift) % 26 + base
            local shifted = ((byte - 65 + shift) % 26) + 65
            table.insert(encrypted_chars, string.char(shifted))
        
        -- Check for Lowercase letters (ASCII range 97-122: 'a' to 'z')
        elseif byte >= 97 and byte <= 122 then
            -- Formula: (x - base + shift) % 26 + base
            local shifted = ((byte - 97 + shift) % 26) + 97
            table.insert(encrypted_chars, string.char(shifted))
        
        -- Non-alphabetic characters (spaces, punctuation, numbers) remain untouched
        else
            table.insert(encrypted_chars, char)
        end
    end
    
    return table.concat(encrypted_chars)
end

--- Decrypts a ciphertext by reversing the shift.
-- @param text string: The ciphertext message to decrypt.
-- @param shift number: The integer shift value (key) used during encryption.
-- @return string: The recovered plaintext.
function Caesar.decrypt(text, shift)
    -- Decryption is mathematically equivalent to encryption with the inverse shift.
    return Caesar.encrypt(text, -shift)
end

-------------------------------------------------------------------------------
-- CRYPTANALYSIS DEMONSTRATION
-------------------------------------------------------------------------------

--- Demonstrates structural weakness via a brute-force attack.
-- Because the Caesar cipher has a keyspace of only 26, an attacker can 
-- instantly test every possible permutation without knowing the key.
-- @param ciphertext string: The intercepted ciphertext.
function Caesar.brute_force(ciphertext)
    print("\n[+] --- STARTING BRUTE-FORCE CRYPTANALYSIS ---")
    print("[*] Keyspace size is 26. Generating all possible plaintexts...\n")
    
    for shift = 0, 25 do
        local candidate = Caesar.decrypt(ciphertext, shift)
        -- Format output neatly, aligning the shift index
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
    local secret_shift = 13 -- ROT13 is a popular symmetrical special case of the Caesar cipher
    
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
    
    -- Launch the brute-force demonstration to showcase vulnerability
    Caesar.brute_force(ciphertext)
end

-- Execute the script
main()
