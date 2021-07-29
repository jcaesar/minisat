#include <zlib.h>
#include "minisat/utils/ParseUtils.h"

namespace Minisat {

//-------------------------------------------------------------------------------------------------
// A simple buffered character stream class:



class StreamBuffer {
    gzFile         in;
    unsigned char* buf;
    int            pos;
    int            size;

    enum { buffer_size = 64*1024 };

    void assureLookahead() {
        if (pos >= size) {
            pos  = 0;
            size = gzread(in, buf, buffer_size); } }

public:
    explicit StreamBuffer(gzFile i) : in(i), pos(0), size(0){
        buf = (unsigned char*)xrealloc(NULL, buffer_size);
        assureLookahead();
    }
    ~StreamBuffer() { free(buf); }

    int  operator *  () const { return (pos >= size) ? EOF : buf[pos]; }
    void operator ++ ()       { pos++; assureLookahead(); }
    int  position    () const { return pos; }
};


//-------------------------------------------------------------------------------------------------
// End-of-file detection functions for StreamBuffer


static inline bool isEof(StreamBuffer& in) { return *in == EOF;  }

}
