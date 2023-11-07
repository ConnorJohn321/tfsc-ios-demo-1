#ifdef __cplusplus

#endif

long long import_base64_prikey_handler(const char *buf, int buf_size);

long long import_prikey_handler_from_hex(const char *str);

char *export_new_prikey_to_hex(long long pkey);

char *export_mnemonic_from_prikey_handler(long long pkey);

long long import_prikey_handler_from_mnemonic(const char *mnemonic);

char *get_base58addr(long long pkey);

char *get_pubstr_base64(long long pkey);

char * get_pubstr(long long pkey,int * out_size);

char *sig_tx(long long pkey, const char *message, int msize);

void free_prikey_handler(long long pkey);

char * get_base58_from_evm(const char * evmAddr);

char *get_evmaddr_from_pubstr(const char * pubstr,int pubstr_size);

char *Decode(const char * base64,int base64_size,int * out_size);

#ifdef __cplusplus

#endif
