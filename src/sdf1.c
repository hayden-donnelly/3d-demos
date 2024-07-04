#include "common/fragctx.h"

extern char * sdf1_frag_source;

int main() 
{
    return run_frag_context(sdf1_frag_source, 512, 512, "SDF1");
}
