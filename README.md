# 🔐 Script senharoot.sh

Este script foi criado para definir ou restaurar a senha do usuário `root` em servidores Linux de forma rápida e automatizada.

> ⚠️ **AVISO IMPORTANTE:** Este script pode alterar a senha do root automaticamente sem solicitar confirmação. Use com atenção e apenas se você souber o que está fazendo.

---

## ✅ Execução direta (modo padrão)

Execute diretamente no terminal com:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/iadsantos/senharoot/main/senharoot.sh)
```

---

## 🔥 Script para configurar o firewall (opcional)

Execute diretamente no terminal com:

```bash
bash <(wget -O configurar_firewall.sh https://raw.githubusercontent.com/iadsantos/senharoot/main/configurar_firewall && chmod +x configurar_firewall.sh && sudo ./configurar_firewall.sh)
```
