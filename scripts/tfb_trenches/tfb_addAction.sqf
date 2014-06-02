_array	= _this select 3;								// arguments
_id		= _this select 2;
_param	= _array select 0;								// first argument (parameters + ID)
_param	= _param + [_id];
_code	= _array select 1;								// second argument (function being called)
_spawn	= _param spawn _code;