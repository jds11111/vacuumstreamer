#!/bin/bash
echo '
#include <stdio.h>
#include <assert.h>

#pragma mark custom



#pragma mark autogenerated
'
readelf -s --wide libagora-rtc-sdk.so |  tr -s ' ' | grep "FUNC GLOBAL DEFAULT" |\
     grep -v "GLOBAL DEFAULT UND" |\
     rev | cut -d ' ' -f1 | rev | while read func; do
        if [ "${func}" == "_init" ] || [ "${func}" == "_fini" ]; then
            continue;
        fi
        echo '
void '"${func}"'(void) {
    printf("-------------------- '"${func}"' --------------------\n");
    assert(0);
}'
done

