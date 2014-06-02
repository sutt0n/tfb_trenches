_array	= _this select 3;			// arguments
_param	= _array select 0;			// first argument
_code	= _array select 1;			// second argument (function call, i.e. tfb_fnDigTrench)
_spawn	= _param spawn _code;