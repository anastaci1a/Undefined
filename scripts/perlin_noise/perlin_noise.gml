/// @description Returns perlin noise generated value [roughly] between -1 and 1.

function perlin_noise(_x, _y = 100.213, _z = 450.4215) {
	
	#region //doubled perm table
	static _p = [
		151,160,137,91,90,15,
		131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
		190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
		88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
		77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
		102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
		135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
		5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
		223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
		129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
		251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
		49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
		138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,
		151,160,137,91,90,15,
		131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
		190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
		88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
		77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
		102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
		135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
		5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
		223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
		129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
		251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
		49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
		138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
	];
	#endregion

    static _fade = function(_t) {
        return _t * _t * _t * (_t * (_t * 6 - 15) + 10);
    }

	static _lerp = function(_t, _a, _b) { 
		return _a + _t * (_b - _a); 
	}

    static _grad = function(_hash, _x, _y, _z) {
        var _h, _u, _v;
        _h = _hash & 15;                       // CONVERT 4 BITS OF HASH CODE
        _u = (_h < 8) ? _x : _y;               // INTO 12 GRADIENT DIRECTIONS.
        if (_h < 4) {
            _v = _y;
        } else if ((_h == 12) || (_h == 14)) {
            _v = _x;
        } else {
            _v = _z;
        }
		if ((_h & 1) != 0) {
			_u = -_u;
		}
		if ((_h & 2) != 0) {
			_v = -_v;
		}		
        return _u + _v;
    }

    var _X, _Y, _Z;
    _X = floor(_x);
    _Y = floor(_y);
    _Z = floor(_z);
    
    _x -= _X;
    _y -= _Y;
    _z -= _Z;
    
    _X = _X & 255;
    _Y = _Y & 255;
    _Z = _Z & 255;
    
    var _u, _v, _w;
    _u = _fade(_x);
    _v = _fade(_y);
    _w = _fade(_z);
    
    var A, AA, AB, B, BA, BB;
    A  = _p[_X]+_Y;
    AA = _p[A]+_Z;
    AB = _p[A+1]+_Z;
    B  = _p[_X+1]+_Y;
    BA = _p[B]+_Z;
    BB = _p[B+1]+_Z;

	//returns a number between -1 and 1
    return _lerp(_w, _lerp(_v, _lerp(_u,_grad(_p[AA  ], _x  , _y  , _z   ),  // AND ADD
										_grad(_p[BA  ], _x-1, _y  , _z   )), // BLENDED
                             _lerp(_u,	_grad(_p[AB  ], _x  , _y-1, _z   ),  // RESULTS
										_grad(_p[BB  ], _x-1, _y-1, _z   ))),// FROM  8
                    _lerp(_v, _lerp(_u,	_grad(_p[AA+1], _x  , _y  , _z-1 ),  // CORNERS
										_grad(_p[BA+1], _x-1, _y  , _z-1 )), // OF CUBE
                             _lerp(_u,	_grad(_p[AB+1], _x  , _y-1, _z-1 ),
										_grad(_p[BB+1], _x-1, _y-1, _z-1 ))));
}