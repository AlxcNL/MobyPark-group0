```mermaid
flowchart TD
    P0[init] -->P00(python)
    P0[init] -->P01(systemd)
    P00 --> P010[jupyterlab]
    P01 --> P011[docker]
    P01 --> P012[sshd]
    P010 --> P0100[bash]
    P010 --> P0101[notebook]
```    