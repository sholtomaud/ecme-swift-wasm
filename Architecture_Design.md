# Architecture Design: Error-Controlled Matrix Engine (ECME)

## 1. Overview
ECME is a Single Executable Application (SEA) designed to implement the **Error-Controlled Matrix Protocol (ECMP)**. It serves as a cybernetic governor for stochastic semantic engines, ensuring that knowledge extraction and synthesis follow a deterministic, zero-error path.

## 2. The Deterministic Sandwich
The core architectural principle is the "Deterministic Sandwich." 
- **Top Layer (Deterministic):** Pass 0 Lexical Anchoring sets boundary conditions.
- **Middle Layer (Stochastic):** Passes 1-6 perform semantic mapping and propositionalizing.
- **Bottom Layer (Deterministic):** Pass 7 Auditor performs a hard-audit of verbatim quotes and graph logic.

## 3. Component Stack
- **Runtime:** Node.js v25 (utilizing native `node:sqlite` and SEA support).
- **Language:** TypeScript 5.x (Strict Mode).
- **Persistence:** SQLite (Content-Addressable Storage via SHA-256 hashing of source text).
- **LLM Interface:** OpenAI-compatible API (supporting local `llama.cpp` servers and cloud providers).
- **Optimization:** NSGA-II Multi-objective Genetic Algorithm.
- **Output:** LaTeX (via `nicematrix` and `tabularray`).

## 4. Data Flow (The Step Machine)
1. **Ingest:** Source text is hashed (SHA-256).
2. **Check Store:** If hash exists in SQLite, resume from the last successful pass.
3. **Execute Pass:** The Step Machine executes the current pass (0-7).
4. **Audit:** If a pass is stochastic, the next deterministic step validates the output.
5. **Commit:** Validated state is saved to SQLite.
6. **Export:** Generate LaTeX tables and matrices for the OES (Optimization of Epistemic Signals).

## 5. Persistence Schema
- `signals`: Stores the raw source and metadata indexed by hash.
- `pass_history`: Stores the JSON state of each pass (0-7) to allow for "Replay" and "Resume" functionality.