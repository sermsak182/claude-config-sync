---
description: สร้าง Diagram - สร้าง Flowchart, Sequence, ER diagram
argument-hint: [type: flow|sequence|er|class] <description>
---

# Diagram Generator - สร้าง diagrams ด้วย Mermaid

## คำสั่ง
```
/diagram [type: flow|sequence|er|class|arch] <description or file>
```

## หน้าที่
สร้าง diagrams อัตโนมัติจาก code หรือ description โดยใช้ Mermaid syntax

## Diagram Types

### 1. Flowchart - ลำดับการทำงาน
```
/diagram flow login process
```

### 2. Sequence - การสื่อสารระหว่าง components
```
/diagram sequence api call
```

### 3. ER Diagram - Database schema
```
/diagram er t_item
```

### 4. Class Diagram - Class structure
```
/diagram class user module
```

### 5. Architecture - System overview
```
/diagram arch
```

## Output Format

### Flowchart
```markdown
## Login Flow

```mermaid
flowchart TD
    A[Start] --> B{Has Session?}
    B -->|Yes| C[Check Session Valid]
    B -->|No| D[Show Login Form]

    C -->|Valid| E[Dashboard]
    C -->|Invalid| D

    D --> F[Submit Credentials]
    F --> G{Validate}

    G -->|Success| H[Create Session]
    G -->|Fail| I[Show Error]

    H --> E
    I --> D

    E --> J[End]
```
```

### Sequence Diagram
```markdown
## API Request Flow

```mermaid
sequenceDiagram
    participant Client
    participant API
    participant Auth
    participant DB

    Client->>API: POST /api/items
    API->>Auth: Validate Token
    Auth-->>API: Token Valid

    API->>DB: INSERT item
    DB-->>API: Success

    API-->>Client: 201 Created

    Note over Client,DB: Item Creation Flow
```
```

### ER Diagram
```markdown
## Database Schema

```mermaid
erDiagram
    t_users ||--o{ t_characters : has
    t_characters ||--o{ t_inventory : owns
    t_inventory }o--|| t_item : contains

    t_users {
        int a_index PK
        string a_username
        string a_password
        datetime a_created
    }

    t_characters {
        int a_index PK
        int a_user_id FK
        string a_name
        int a_level
        int a_race
    }

    t_item {
        int a_index PK
        string a_name
        int a_type_idx
        int a_att_flag
    }

    t_inventory {
        int a_index PK
        int a_char_id FK
        int a_item_index FK
        int a_quantity
    }
```
```

### Class Diagram
```markdown
## Class Structure

```mermaid
classDiagram
    class ItemService {
        -PDO db
        +getItem(id) Item
        +createItem(data) Item
        +updateItem(id, data) bool
        +deleteItem(id) bool
    }

    class Item {
        +int index
        +string name
        +int typeIdx
        +int attFlag
        +hasFlag(flag) bool
        +addFlag(flag) void
    }

    class ItemValidator {
        +validate(data) bool
        +sanitize(data) array
    }

    ItemService --> Item
    ItemService --> ItemValidator
```
```

### Architecture Diagram
```markdown
## System Architecture

```mermaid
flowchart TB
    subgraph Client Layer
        Web[Web Browser]
        Game[Game Client]
    end

    subgraph Application Layer
        Admin[DR Admin Panel<br/>PHP]
        API[REST API<br/>PHP]
    end

    subgraph Game Server Layer
        Connect[Connect Server<br/>Port 4015]
        Laghaim[Game Server<br/>Port 6001-6047]
        Helper[Helper Server<br/>Port 4012]
        Messenger[Chat Server<br/>Port 4011]
    end

    subgraph Data Layer
        MySQL[(MySQL<br/>4 Databases)]
        Files[Game Files<br/>.DTA, .LOLO]
    end

    Web --> Admin
    Web --> API
    Game --> Connect
    Game --> Laghaim
    Game --> Messenger

    Admin --> MySQL
    API --> MySQL
    Connect --> MySQL
    Laghaim --> MySQL
    Laghaim --> Files

    Connect --> Laghaim
    Laghaim --> Helper
```
```

### State Diagram
```markdown
## Character States

```mermaid
stateDiagram-v2
    [*] --> Idle

    Idle --> Moving: Move Command
    Idle --> Attacking: Attack Command
    Idle --> Casting: Skill Command

    Moving --> Idle: Arrive
    Moving --> Attacking: Attack Command

    Attacking --> Idle: Target Dead
    Attacking --> Dead: HP = 0

    Casting --> Idle: Cast Complete
    Casting --> Dead: HP = 0

    Dead --> [*]: Respawn
```
```

### Gantt Chart
```markdown
## Project Timeline

```mermaid
gantt
    title DR Admin Development
    dateFormat  YYYY-MM-DD

    section Phase 1
    Item Management     :done, 2024-01-01, 2024-01-15
    NPC Management      :done, 2024-01-10, 2024-01-20
    Shop System         :active, 2024-01-15, 2024-02-01

    section Phase 2
    Drop System         :2024-02-01, 2024-02-15
    Zone Management     :2024-02-10, 2024-02-25

    section Phase 3
    Character Tools     :2024-03-01, 2024-03-15
    Guild Management    :2024-03-10, 2024-03-25
```
```

## Auto-Generate from Code

### From PHP File
```
/diagram flow public/edit_item_advanced.php
```

Output:
```mermaid
flowchart TD
    A[Request] --> B{GET or POST?}
    B -->|GET| C[Load Item Data]
    B -->|POST| D[Validate Input]

    C --> E[Render Form]

    D --> F{Valid?}
    F -->|Yes| G[Update Database]
    F -->|No| H[Show Errors]

    G --> I[Redirect with Success]
    H --> E
```

### From Database Tables
```
/diagram er t_item t_npc_drop t_zone_drop
```

## Rendering Options

### In Markdown
GitHub, GitLab, และ editors หลายตัว render Mermaid อัตโนมัติ

### Export to Image
```bash
# ใช้ mermaid-cli
npx @mermaid-js/mermaid-cli mmdc -i diagram.mmd -o diagram.png

# Online
# https://mermaid.live/
```

### In HTML
```html
<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>

<div class="mermaid">
flowchart TD
    A --> B
</div>
```

## ตัวอย่างการใช้งาน

```
/diagram flow login
/diagram sequence item purchase
/diagram er                        # All tables
/diagram er t_item t_shop
/diagram class utils/
/diagram arch                      # Full system
```

## Notes
- ใช้ Mermaid syntax มาตรฐาน
- Render ได้ใน GitHub/GitLab
- Export เป็น PNG/SVG ได้
- Auto-generate จาก code
