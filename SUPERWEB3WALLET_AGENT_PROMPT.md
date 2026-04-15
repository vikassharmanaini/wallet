# 🦊 SuperWeb3Wallet — Flutter Code Agent Master Prompt

> **App Name:** SuperWeb3Wallet  
> **Platform:** Flutter (iOS + Android)  
> **Reference:** MetaMask Mobile (full feature parity + enhancements)  
> **Agent Mode:** Sequential — complete each phase before proceeding to the next  
> **Last Updated:** 2026-04-16

---

## 🤖 Agent Instructions — Read This First

You are a senior Flutter/Web3 engineer. Your job is to build **SuperWeb3Wallet** — a production-grade, non-custodial crypto wallet for iOS and Android. Follow this document **phase by phase, feature by feature**. Do not skip steps. After each phase, run `flutter analyze` and fix all errors before continuing.

### Rules
1. **Architecture:** Clean Architecture + BLoC/Cubit for state management
2. **No hardcoded strings** — use `l10n` (flutter_localizations)
3. **No secrets in code** — use `flutter_secure_storage` for all sensitive data
4. **Every screen must have a matching widget test** (place in `/test/`)
5. **Comment every public method** with dartdoc `///`
6. **Use `freezed` + `json_serializable`** for all data models
7. After completing each numbered feature section, output:  
   `✅ PHASE [N] COMPLETE — [feature name]`

---

## 📁 Project Structure

```
superweb3wallet/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── network/
│   │   ├── router/           # go_router
│   │   ├── theme/
│   │   └── utils/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   └── presentation/
│       ├── blocs/
│       ├── screens/
│       └── widgets/
├── test/
├── assets/
│   ├── icons/
│   ├── images/
│   └── animations/          # Lottie JSON files
└── pubspec.yaml
```

---

## 📦 pubspec.yaml — Required Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Web3 / Crypto
  web3dart: ^2.7.3
  bip39: ^1.0.6
  bip32: ^2.0.0
  ed25519_hd_key: ^2.3.0
  convert: ^3.1.1
  pointycastle: ^3.7.4
  hex: ^0.2.0

  # Networking
  dio: ^5.4.0
  web_socket_channel: ^2.4.0

  # State Management
  flutter_bloc: ^8.1.4
  equatable: ^2.0.5

  # Storage & Security
  flutter_secure_storage: ^9.0.0
  hive_flutter: ^1.1.0
  hive: ^2.2.3

  # Navigation
  go_router: ^13.2.0

  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # UI
  lottie: ^3.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  fl_chart: ^0.66.2
  qr_flutter: ^4.1.0
  mobile_scanner: ^5.1.1   # QR scanner

  # Biometrics
  local_auth: ^2.2.0

  # Clipboard & Share
  share_plus: ^7.2.1
  flutter_clipboard_manager: ^0.0.2

  # Deep Links / WalletConnect
  walletconnect_flutter_v2: ^2.1.9
  app_links: ^6.1.0

  # Notifications
  flutter_local_notifications: ^17.1.2

  # Utils
  intl: ^0.19.0
  url_launcher: ^6.2.5
  package_info_plus: ^8.0.0
  device_info_plus: ^10.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.8
  freezed: ^2.5.2
  json_serializable: ^6.7.1
  hive_generator: ^2.0.1
  bloc_test: ^9.1.5
  mocktail: ^1.0.3
  flutter_lints: ^4.0.0
```

---

## 🔐 PHASE 1 — Wallet Creation & Import

### 1.1 Onboarding Flow
Create an onboarding screen with:
- Animated SuperWeb3Wallet logo (Lottie)
- "Create a New Wallet" button
- "Import Using Secret Recovery Phrase" button
- "Import Using Private Key" button
- Privacy policy & Terms of Service links (WebView)

### 1.2 Create New Wallet
Implement the following screens in order:

**Step 1 — Password Setup**
```dart
// Create: lib/presentation/screens/onboarding/create_password_screen.dart
// Requirements:
// - Password field (min 8 chars, 1 uppercase, 1 number, 1 special char)
// - Confirm password field
// - Strength indicator (Weak / Fair / Strong / Very Strong) with color bar
// - "I understand I am responsible for keeping my wallet secure" checkbox
// - Continue button (disabled until valid)
```

**Step 2 — Secret Recovery Phrase (SRP) Generation**
```dart
// Create: lib/domain/usecases/generate_mnemonic_usecase.dart
// Use bip39 package to generate 12-word mnemonic
// NEVER log or transmit the mnemonic
// Display words in a 3-column grid (4 rows × 3 cols)
// Show/Hide toggle button
// "Copy to clipboard" — show warning: "This is unsafe"
// "Continue" only activates after user taps "I wrote it down safely"
```

**Step 3 — SRP Verification Quiz**
```dart
// Randomly pick 3 words from the mnemonic (e.g., word #3, #7, #11)
// Show blank fields for those positions
// User must type the correct words to pass
// On failure: show "Incorrect, try again" snackbar
// On success: navigate to wallet home
```

### 1.3 Import Wallet
**Import via SRP (12/24 words)**
```dart
// Create: lib/presentation/screens/onboarding/import_srp_screen.dart
// Paste field OR individual word fields (toggle)
// Validate using bip39.validateMnemonic()
// On valid: derive HD wallet → store encrypted in flutter_secure_storage
// Show "Invalid phrase" error inline
```

**Import via Private Key (64 hex chars)**
```dart
// Create: lib/presentation/screens/onboarding/import_private_key_screen.dart
// Single text field for 64-char hex private key
// Validate length and hex format
// Derive address using web3dart EthPrivateKey.fromHex()
```

### 1.4 Key Derivation (HD Wallet — BIP32/BIP44)
```dart
// Create: lib/data/datasources/wallet_key_derivation.dart
// Derivation path: m/44'/60'/0'/0/accountIndex  (Ethereum)
// Support multiple accounts (index 0, 1, 2...)
// Store: encrypted mnemonic, encrypted private keys, public addresses
// Use: flutter_secure_storage with AES-256-GCM encryption wrapper
```

**Deliverable:** Wallet creation, SRP backup quiz, import flows all working end-to-end.

---

## 💰 PHASE 2 — Wallet Home & Portfolio

### 2.1 Home Screen Layout
```dart
// Create: lib/presentation/screens/home/home_screen.dart
// Top bar: Network selector pill | Avatar/Identicon | Notifications bell
// Account section:
//   - Account name (editable, tap to rename)
//   - Truncated address (0x1234...5678) with copy icon
//   - Total balance in USD (large, bold)
//   - 24h change % with green/red arrow
// Action buttons row: [Send] [Receive] [Buy] [Swap] [Bridge]
// Tabs: [Tokens] [NFTs] [Activity] [DeFi]
```

### 2.2 Identicon / Avatar
```dart
// Generate Ethereum-style blockie identicon from address
// Implement using canvas drawing (CustomPainter)
// User can also set a custom emoji or uploaded photo
// Store avatar preference in Hive
```

### 2.3 Portfolio Balance
```dart
// Create: lib/domain/usecases/fetch_portfolio_balance_usecase.dart
// Fetch ETH balance: web3dart getBalance()
// Fetch ERC-20 token balances via Alchemy/Infura JSON-RPC
// Fetch USD prices from CoinGecko API (free tier)
// Aggregate total USD value across all tokens
// Cache prices in Hive (expire every 60 seconds)
// Show shimmer loading skeleton while fetching
```

### 2.4 Multi-Account Support
```dart
// Create: lib/presentation/screens/accounts/accounts_screen.dart
// List all HD accounts (name, address, balance)
// "Add Account" button — derives next index from same mnemonic
// "Import Account" — private key only (marked as "Imported")
// Switch active account (updates all screens)
// Account detail: rename, view on Etherscan, remove imported
```

---

## 🌐 PHASE 3 — Network Management

### 3.1 Built-in Networks
Pre-configure these networks in `assets/networks.json`:

```json
[
  {"name":"Ethereum","chainId":1,"rpcUrl":"https://mainnet.infura.io/v3/YOUR_KEY","symbol":"ETH","explorer":"https://etherscan.io"},
  {"name":"Polygon","chainId":137,"rpcUrl":"https://polygon-rpc.com","symbol":"MATIC","explorer":"https://polygonscan.com"},
  {"name":"BNB Smart Chain","chainId":56,"rpcUrl":"https://bsc-dataseed.binance.org","symbol":"BNB","explorer":"https://bscscan.com"},
  {"name":"Arbitrum One","chainId":42161,"rpcUrl":"https://arb1.arbitrum.io/rpc","symbol":"ETH","explorer":"https://arbiscan.io"},
  {"name":"Optimism","chainId":10,"rpcUrl":"https://mainnet.optimism.io","symbol":"ETH","explorer":"https://optimistic.etherscan.io"},
  {"name":"Avalanche C-Chain","chainId":43114,"rpcUrl":"https://api.avax.network/ext/bc/C/rpc","symbol":"AVAX","explorer":"https://snowtrace.io"},
  {"name":"Base","chainId":8453,"rpcUrl":"https://mainnet.base.org","symbol":"ETH","explorer":"https://basescan.org"},
  {"name":"Sepolia Testnet","chainId":11155111,"rpcUrl":"https://sepolia.infura.io/v3/YOUR_KEY","symbol":"ETH","explorer":"https://sepolia.etherscan.io"}
]
```

### 3.2 Network Selector UI
```dart
// Bottom sheet showing all networks with:
// - Chain icon, name, currently active indicator
// - "Add Network" button at bottom
// Active network shown as pill in home screen top bar
// Switching networks refreshes all balances
```

### 3.3 Add Custom Network
```dart
// Create: lib/presentation/screens/networks/add_network_screen.dart
// Fields: Network Name, RPC URL, Chain ID, Symbol, Block Explorer URL
// Validate: ping the RPC URL and confirm chainId matches
// Show "Network added successfully" on success
// Allow edit/delete of custom networks
```

---

## 📤 PHASE 4 — Send Tokens

### 4.1 Send Flow (ETH & ERC-20)
```dart
// Create: lib/presentation/screens/send/send_screen.dart

// Step 1 — Asset Selection
// - Searchable list of tokens in wallet
// - Show balance per token

// Step 2 — Recipient
// - Address text field with paste button
// - QR code scanner (mobile_scanner package)
// - ENS name resolution (query ENS resolver contract)
// - Recent addresses list (stored in Hive)
// - Address book contacts

// Step 3 — Amount
// - Token amount input with USD conversion (live)
// - "Max" button (calculates balance minus gas)
// - Switch between token / USD input mode

// Step 4 — Gas Configuration
// - Show estimated gas fee in ETH + USD
// - Three presets: [🐢 Low] [⚡ Market] [🚀 Fast]
// - "Advanced" toggle: manual Gas Limit + Max Fee + Priority Fee (EIP-1559)
// - Estimated confirmation time per preset

// Step 5 — Review & Confirm
// - Full summary: From, To, Amount, Network, Gas, Total cost
// - Biometric authentication (local_auth) before sending
// - Send button triggers signTransaction + sendRawTransaction

// Step 6 — Transaction Submitted
// - Animated checkmark (Lottie)
// - Tx hash with "View on Explorer" link
// - "Share" button
```

### 4.2 Batch Transactions
```dart
// Allow user to queue multiple sends
// Execute sequentially with nonce management
```

---

## 📥 PHASE 5 — Receive

```dart
// Create: lib/presentation/screens/receive/receive_screen.dart
// Large QR code (qr_flutter) containing address
// Address text below, tap to copy
// Network warning badge ("Only send [ETH] on [Ethereum Mainnet]")
// Share button (share_plus) — shares address as text + QR image
// "Request specific amount" — encodes amount into EIP-681 URI
```

---

## 🔄 PHASE 6 — Token Management

### 6.1 Token List (Tokens Tab)
```dart
// Display each token:
//   Icon | Name | Balance (token) | Balance (USD) | 24h % change
// Pull-to-refresh
// Token tap → Token Detail screen
```

### 6.2 Token Detail Screen
```dart
// Create: lib/presentation/screens/tokens/token_detail_screen.dart
// Price chart (fl_chart) — 1D / 1W / 1M / 3M / 1Y
// Send / Receive / Swap / Buy buttons
// Scrollable transaction history for this token
// Token info: contract address, decimals, total supply
// "View on Etherscan" / "Add to MetaMask" links
```

### 6.3 Add Custom Token (ERC-20)
```dart
// Create: lib/presentation/screens/tokens/add_token_screen.dart
// Search by name/symbol from token list (Uniswap token list JSON)
// Manual import: Contract address → auto-fetch name, symbol, decimals
// Confirm "Add Token" → appears in token list
// Hide/remove token
```

### 6.4 Auto Token Detection
```dart
// On wallet load, query Alchemy getTokensForOwner() API
// Auto-detect and suggest newly received ERC-20 tokens
// Show "Token detected" notification with option to add
```

---

## 🖼️ PHASE 7 — NFT Gallery

### 7.1 NFT Grid
```dart
// Create: lib/presentation/screens/nfts/nft_grid_screen.dart
// Fetch NFTs via Alchemy getNFTsForOwner() API
// Grid view (2 columns) with cached_network_image
// Show: image/video, collection name, token name
// Empty state illustration when no NFTs
```

### 7.2 NFT Detail Screen
```dart
// Full-screen media (image/GIF/video/3D)
// Metadata: name, description, traits/attributes table
// Collection info
// Send NFT button (ERC-721 / ERC-1155 transfer)
// "View on OpenSea" deep link
// Share button
```

---

## 📜 PHASE 8 — Transaction History

### 8.1 Activity Tab
```dart
// Create: lib/presentation/screens/activity/activity_screen.dart
// Fetch transactions from Etherscan API (paginated)
// Group by date header ("Today", "Yesterday", "Apr 10")
// Each item shows:
//   Icon (↑ Send / ↓ Receive / 🔄 Swap / 📜 Contract)
//   Status badge: Pending (animated) / Confirmed / Failed
//   Address (from/to), amount, gas paid, time
// Tap → Transaction Detail
```

### 8.2 Transaction Detail Screen
```dart
// Full tx info: hash, block, nonce, gas used, gas price
// Status with block confirmations count
// "Speed Up" button (if pending) — resubmit with higher gas
// "Cancel" button (if pending) — send 0 ETH to self with same nonce + higher gas
// "View on Block Explorer" link
// "Copy Tx Hash" button
```

### 8.3 Pending TX Monitor
```dart
// Background WebSocket subscription to new blocks (web_socket_channel)
// Check all pending TXs on each new block
// Push local notification when TX confirmed/failed (flutter_local_notifications)
```

---

## 🔁 PHASE 9 — Swap

### 9.1 Swap Screen
```dart
// Create: lib/presentation/screens/swap/swap_screen.dart
// Token pair selector: [Token A ▼] [↕ flip] [Token B ▼]
// Amount input for Token A → auto-calculate Token B amount
// Fetch quotes from 1inch Aggregation API v5 (/swap/v5.2/1/quote)
// Show: exchange rate, price impact %, minimum received, route path
// Slippage settings (0.1% / 0.5% / 1.0% / custom)
// Gas estimate
// "Review Swap" → confirmation screen → sign & submit tx
// Route visualization: Token A → DEX1 → DEX2 → Token B
```

### 9.2 Swap History
```dart
// Separate swap history tab or filter in Activity
// Show swapped pairs and rates
```

---

## 🌉 PHASE 10 — Bridge

```dart
// Create: lib/presentation/screens/bridge/bridge_screen.dart
// Integrate LI.FI SDK or Socket.tech API
// Fields: From Network, To Network, Token, Amount
// Show: estimated received, fees, estimated time
// Multiple route options ranked by best output
// "Bridge" → review → sign approval + bridge tx
// Bridge progress tracker (steps: Approve → Bridge → Relay → Done)
```

---

## 💳 PHASE 11 — Buy Crypto

```dart
// Create: lib/presentation/screens/buy/buy_screen.dart
// Integrate MoonPay widget (WebView)
// Integrate Transak widget (WebView)
// Show provider comparison: rates, fees, payment methods
// Payment methods: Credit/Debit Card, Bank Transfer, Apple Pay, Google Pay
// KYC redirect handled via WebView
// On-ramp completion → show received tx in Activity
```

---

## 🌐 PHASE 12 — In-App Browser & DApp Integration

### 12.1 In-App Browser
```dart
// Create: lib/presentation/screens/browser/browser_screen.dart
// WebView with address bar (webview_flutter or flutter_inappwebview)
// Navigation: Back, Forward, Refresh, Home, Bookmarks
// URL bar with search (Google/DuckDuckGo fallback)
// Show site security indicator (🔒 / ⚠️)
// Inject Web3 Provider (EIP-1193) into page JavaScript context
// Default homepage: DApp discovery grid (curated list)
```

### 12.2 Web3 Provider Injection
```dart
// Inject window.ethereum into WebView JavaScript
// Handle these RPC methods:
//   eth_requestAccounts       → return active address
//   eth_accounts              → return active address
//   eth_chainId               → return current chainId hex
//   personal_sign             → show sign modal → biometric auth → sign
//   eth_sign                  → same
//   eth_signTypedData_v4      → parse EIP-712 data → show readable modal
//   eth_sendTransaction       → show send confirmation → sign → submit
//   wallet_switchEthereumChain → show network switch prompt
//   wallet_addEthereumChain   → show add network prompt
```

### 12.3 DApp Connection Modal
```dart
// When DApp calls eth_requestAccounts:
// Show bottom sheet:
//   - DApp logo + name + URL
//   - "This site wants to connect to your wallet"
//   - Account selector (which account to expose)
//   - [Connect] [Cancel] buttons
// Store connected DApp sessions in Hive
// "Connected Sites" settings page to revoke connections
```

### 12.4 Browser Bookmarks & History
```dart
// Save/remove bookmarks
// Browse history (last 100 sites)
// Clear history option
// Favorites grid on new tab page
```

---

## 🔗 PHASE 13 — WalletConnect v2

```dart
// Package: walletconnect_flutter_v2
// Create: lib/data/datasources/wallet_connect_service.dart

// Pairing:
//   - Scan WalletConnect QR code (from desktop DApp)
//   - Accept/Reject session proposal
//   - Show DApp info (name, URL, icon, requested permissions)

// Session Management:
//   - List active WC sessions in Settings
//   - Disconnect individual sessions
//   - Session persisted in Hive

// Request Handling (same as browser provider):
//   - eth_sendTransaction → confirmation modal
//   - personal_sign / eth_signTypedData_v4 → sign modal
//   - wallet_switchEthereumChain → network switch modal

// Deep Link Support (app_links):
//   - Handle wc:// URIs from other apps
//   - Auto-open pairing modal
```

---

## ✍️ PHASE 14 — Message & Data Signing

### 14.1 Personal Sign Modal
```dart
// Create: lib/presentation/widgets/sign/personal_sign_modal.dart
// Show: DApp requesting, full message text (scrollable)
// Decode hex message to UTF-8 if possible
// Warning if message contains suspicious patterns
// [Sign] [Reject] — biometric auth before signing
```

### 14.2 EIP-712 Typed Data Sign Modal
```dart
// Parse typed data JSON
// Display structured fields in human-readable table
// Show domain: name, version, chainId, verifyingContract
// Highlight primary type and its fields
// [Sign] [Reject] — biometric auth before signing
```

### 14.3 Transaction Confirmation Modal
```dart
// Create: lib/presentation/widgets/sign/tx_confirm_modal.dart
// Show: to address, value, data (hex, decoded if ABI known)
// Decode common function signatures (transfer, approve, etc.)
// Gas fee estimate with edit button
// [Confirm] [Reject] — biometric auth
// "I understand the risks" for unrecognized contract calls
```

---

## 🔒 PHASE 15 — Security

### 15.1 Biometric Authentication
```dart
// Use local_auth package
// Lock app after X minutes background (configurable: 1/5/15/30 min/never)
// Re-authenticate with biometrics or PIN on return
// Biometric gate for:
//   - Signing transactions
//   - Revealing SRP/private key
//   - Sending funds
```

### 15.2 Auto-Lock
```dart
// AppLifecycleState.paused → start lock timer
// AppLifecycleState.resumed → check if timer expired → show lock screen
// Lock screen: blur background + biometric prompt
```

### 15.3 Reveal SRP / Private Key
```dart
// Create: lib/presentation/screens/security/reveal_srp_screen.dart
// Password re-entry required (not biometric — MetaMask requirement)
// Show warning modal ("Anyone with this phrase...")
// Blur overlay on SRP — tap to reveal
// Prevent screenshots (FLAG_SECURE on Android, blur on iOS app switcher)
```

### 15.4 Phishing Detection
```dart
// Maintain phishing domain list (from MetaMask's eth-phishing-detect list)
// Check every URL before loading in browser
// Show full-screen WARNING page if phishing domain detected
// Allow user to "Proceed Anyway" with extra confirmation
```

### 15.5 Transaction Simulation (Security)
```dart
// Integrate Tenderly simulation API or Blowfish API
// Before user signs TX: simulate it and show:
//   - Expected balance changes (what you will lose/gain)
//   - Red warning if tx looks malicious
//   - "This looks like a drainer contract" alerts
```

---

## ⚙️ PHASE 16 — Settings

```dart
// Create: lib/presentation/screens/settings/settings_screen.dart

// GENERAL
// - Currency display (USD, EUR, GBP, INR, JPY...)
// - Language selection (English, Hindi, Spanish, Chinese...)
// - Theme: Light / Dark / System
// - Primary color accent picker

// SECURITY & PRIVACY
// - Change password
// - Biometrics toggle
// - Auto-lock timer
// - Reveal Secret Recovery Phrase
// - Reveal Private Key (per account)
// - Connected Sites (revoke DApp connections)
// - Clear browser history / cookies

// NETWORKS
// - Manage networks (list, add, edit, delete custom)
// - Show/hide test networks toggle

// ADVANCED
// - Gas fee customization defaults
// - Nonce customization (allow manual override)
// - Reset account (clear tx history cache — NOT keys)
// - IPFS gateway selector
// - State logs export (for debugging)
// - Dismiss MetaMask migration prompt

// NOTIFICATIONS
// - Toggle: Tx confirmed, Tx failed, Token detected
// - Toggle: Price alerts

// ABOUT
// - App version, build number
// - Terms of Service
// - Privacy Policy
// - Support link
// - Rate the app
```

---

## 🎨 PHASE 17 — UI/UX & Theming

### 17.1 Design System
```dart
// Create: lib/core/theme/app_theme.dart
// Color palette:
//   Primary:    #037DD6 (MetaMask blue) 
//   Secondary:  #F6851B (MetaMask orange)
//   Success:    #28A745
//   Warning:    #FFC107
//   Danger:     #D73A49
//   Background: #FFFFFF / #1A1A1F (dark)
//   Surface:    #F2F4F6 / #24272A (dark)
// Typography: Google Fonts — Euclid Circular B (or Outfit)
// Border radius: 12px default, 8px small, 24px large
// Elevation: use shadows not Material elevation
```

### 17.2 Dark Mode
```dart
// Full dark mode implementation
// System theme detection
// Manual override in Settings
// Persist preference in Hive
```

### 17.3 Animations
```dart
// Page transitions: custom slide + fade
// Lottie animations:
//   - Onboarding splash (fox logo animation)
//   - Transaction success (green checkmark)
//   - Transaction pending (spinning loader)
//   - Empty states (no tokens, no NFTs, no activity)
// Shimmer loading for all list items / balances
// Hero animations: token icon → token detail
```

### 17.4 Haptic Feedback
```dart
// HapticFeedback.mediumImpact() on button taps
// HapticFeedback.lightImpact() on toggle changes
// HapticFeedback.heavyImpact() on transaction confirm
```

---

## 🔔 PHASE 18 — Notifications & Alerts

```dart
// Create: lib/data/datasources/notification_service.dart
// Local notifications (flutter_local_notifications):
//   - Transaction confirmed: "✅ Sent 0.5 ETH — confirmed!"
//   - Transaction failed: "❌ Transaction failed — tap to view"
//   - New token received: "💰 Received 100 USDC"
//   - Price alert: "🚀 ETH up 10% in the last hour"
// Notification tap → navigate to relevant screen (go_router deep link)
// Notification history screen in Settings
```

---

## 🧪 PHASE 19 — Testing Requirements

For every phase, write tests in `/test/`:

```dart
// Unit tests (domain + data layer):
//   - Mnemonic generation produces valid BIP39 words
//   - Key derivation produces correct Ethereum addresses
//   - Transaction signing produces correct signature
//   - Balance fetching handles network errors gracefully
//   - Gas estimation logic

// Widget tests (presentation layer):
//   - All screens render without overflow
//   - Password strength indicator shows correct state
//   - SRP quiz rejects wrong words
//   - Send flow validates inputs correctly
//   - Sign modals display correct data

// BLoC tests:
//   - WalletBloc: createWallet, importWallet, switchAccount
//   - NetworkBloc: switchNetwork, addNetwork
//   - SendBloc: validate address, estimate gas, submit tx
//   - SwapBloc: fetch quote, execute swap

// Golden tests (screenshot tests):
//   - Home screen (light + dark)
//   - Token detail screen
//   - Send confirmation modal
```

---

## 🚀 PHASE 20 — Production Hardening

### 20.1 Code Obfuscation
```bash
# Add to android/app/build.gradle:
# buildTypes { release { minifyEnabled true, shrinkResources true } }
# Flutter build command:
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
flutter build ipa --release --obfuscate --split-debug-info=build/debug-info
```

### 20.2 Certificate Pinning
```dart
// Use dio + custom HttpClient with pinned certificates
// For RPC endpoints (Infura, Alchemy)
// Fallback RPCs if primary fails
```

### 20.3 Root/Jailbreak Detection
```dart
// Use flutter_jailbreak_detection package
// On detected: show warning modal (don't block, just warn)
```

### 20.4 Screenshot Prevention
```dart
// Android: getWindow().setFlags(FLAG_SECURE, FLAG_SECURE) on sensitive screens
// iOS: Add UITextField secureTextEntry workaround for blur
// Screens affected: SRP reveal, private key reveal, lock screen
```

### 20.5 Analytics (Privacy-Preserving)
```dart
// Integrate Mixpanel or Segment (no PII, no addresses)
// Track: feature usage, error rates, performance metrics
// Respect user opt-out setting
```

---

## 🔄 Agent Execution Order

Execute phases in this exact order:

```
Phase 1  → Wallet Creation & Import          [FOUNDATION - do first]
Phase 15 → Security (biometrics, auto-lock)  [needed by all phases]
Phase 17 → UI Theming                        [needed by all screens]
Phase 2  → Home & Portfolio
Phase 3  → Network Management
Phase 4  → Send
Phase 5  → Receive
Phase 6  → Token Management
Phase 7  → NFT Gallery
Phase 8  → Transaction History
Phase 9  → Swap
Phase 10 → Bridge
Phase 11 → Buy Crypto
Phase 12 → In-App Browser
Phase 13 → WalletConnect v2
Phase 14 → Message Signing
Phase 16 → Settings
Phase 18 → Notifications
Phase 19 → Tests
Phase 20 → Production Hardening
```

---

## ✅ Completion Checklist

After all phases, verify:

- [ ] App launches without errors on Android emulator
- [ ] App launches without errors on iOS simulator
- [ ] Create wallet → backup SRP → complete quiz → reach home screen
- [ ] Import wallet via SRP → reach home screen with correct address
- [ ] Switch between Ethereum and Polygon networks
- [ ] Send 0.001 ETH on Sepolia testnet
- [ ] WalletConnect pairing works with app.uniswap.org
- [ ] Biometric lock activates after background
- [ ] SRP reveal requires password entry
- [ ] All widget tests pass: `flutter test`
- [ ] No analyzer warnings: `flutter analyze`
- [ ] APK builds in release mode
- [ ] IPA builds in release mode

---

## 📋 Quick Reference — Key RPC Calls

```dart
// ETH balance
await client.getBalance(EthereumAddress.fromHex(address));

// ERC-20 balance
final erc20 = DeployedContract(ContractAbi.fromJson(erc20ABI, 'Token'), contractAddress);
final result = await client.call(contract: erc20, function: erc20.function('balanceOf'), params: [walletAddress]);

// Send ETH
final tx = Transaction(to: recipient, value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount));
final txHash = await client.sendTransaction(credentials, tx, chainId: chainId);

// Sign message (personal_sign)
final signature = await credentials.signPersonalMessage(Uint8List.fromList(message.codeUnits));

// Gas estimate
final gas = await client.estimateGas(sender: address, to: recipient, value: value, data: data);

// EIP-1559 gas
final feeHistory = await client.getFeeHistory(blockCount: 5, newestBlock: 'latest', rewardPercentiles: [25, 50, 75]);
```

---

*Built with ❤️ for the decentralized future — SuperWeb3Wallet v1.0*
