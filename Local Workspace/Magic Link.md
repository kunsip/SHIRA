# Rational
Users should not be required to memorize another password to access Sapphire Pack.
```mermaid
graph TD;
  A{New User};
  A --> |Yes| B[Create Account]
  B --> C
  A --> |No| C[Send Magic Link]
```

# Warnings
Magic Links currently DO NOT EXPIRE.
Magic Links do not have basic security levels.
Magic Links automatically create user 