Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC57467630
	for <lists+linux-s390@lfdr.de>; Fri,  3 Dec 2021 12:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380378AbhLCL0R (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Dec 2021 06:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243477AbhLCL0Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Dec 2021 06:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638530572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IymphDaNy8Caf2ydY0dE5fG+Pn7fihEWUEErdH0dHFk=;
        b=JL/tMFWNcWARo/Ggp7Au9YER0+PJ6W2gbOWxe3pb0fvNWIc6CIgcnfGl6sN+grV1r1aRpS
        YnAQhqqN2RKe5Eo5zd8RHrrspm90HU5PhI49Y5PGnrc40QPSUcCyO/NYpHODyMc0eC4AxY
        S8IkqTSoK9xl8rdoT6kqRL29t7W7yTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-CANU6gewNoyFoerjINZG7A-1; Fri, 03 Dec 2021 06:22:51 -0500
X-MC-Unique: CANU6gewNoyFoerjINZG7A-1
Received: by mail-wm1-f71.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so3289500wmc.7
        for <linux-s390@vger.kernel.org>; Fri, 03 Dec 2021 03:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IymphDaNy8Caf2ydY0dE5fG+Pn7fihEWUEErdH0dHFk=;
        b=kwTgRGoNy6l+zbcbtuaiBTutfbkYw1fkSplW3iT1h0m533psu4AhwSwkt9IrbfBtQa
         DdSQoW8YcGOQjzVZGRzQB1N5Ye/JYKZP+guT3yAPWmZApqa7Tq1qh7q/si9eKYbtwbkH
         t0rUKs1rfJLZeLCXj/ZTozGNKUvrx3rhBY/ZeVe0YBevM8ffoMIMyVKnhCMgTm4UX0Hc
         XmS2unOTDKJAGdEV+fvyzS//us4Kx1lS/S4q8hr8wUA8d8/mJWYN6YjULT03sd3/vhkP
         L/YmlukxwZStq0g+YJq3WF7sggssNBbiTlNOwO4VuKt5z68fUgGNQIkrpV/FAgBnJHGD
         L5Gg==
X-Gm-Message-State: AOAM53079tFtiDsjWGqIbRvaU44th9cFVvXlV5JIYMEphVGpcR7WiIxa
        pmZpBSNqXSIIqC7VDAPmNIXnTPEjXyXMu4ALIAwAq2zfT9cQM5x3Tioqncx7QLgxNgq7LlhJoh6
        AjtnFwca4i0yzXSoCBltrGg==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr14103590wmq.22.1638530568926;
        Fri, 03 Dec 2021 03:22:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXZw2b2beme0syQIMDho7kOHkuCQJ29YlpAFGIPtBB3pbiCuyCjv89RYo3hTw6z5gCgFvs/g==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr14103556wmq.22.1638530568671;
        Fri, 03 Dec 2021 03:22:48 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id y142sm2418180wmc.40.2021.12.03.03.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 03:22:48 -0800 (PST)
Message-ID: <10bf23af-d6ff-965b-d360-5f1bd65a7a88@redhat.com>
Date:   Fri, 3 Dec 2021 12:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [kvm-unit-tests PATCH v2 2/2] s390x: firq: floating interrupt
 test
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202123553.96412-1-david@redhat.com>
 <20211202123553.96412-3-david@redhat.com>
 <11f0ff2f-2bae-0f1b-753f-b0e9dc24b345@redhat.com>
 <20211203121819.145696b0@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20211203121819.145696b0@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/12/2021 12.18, Claudio Imbrenda wrote:
> On Fri, 3 Dec 2021 11:55:31 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 02/12/2021 13.35, David Hildenbrand wrote:
>>> We had a KVM BUG fixed by kernel commit a3e03bc1368c ("KVM: s390: index
>>> kvm->arch.idle_mask by vcpu_idx"), whereby a floating interrupt might get
>>> stuck forever because a CPU in the wait state would not get woken up.
>>>
>>> The issue can be triggered when CPUs are created in a nonlinear fashion,
>>> such that the CPU address ("core-id") and the KVM cpu id don't match.
>>>
>>> So let's start with a floating interrupt test that will trigger a
>>> floating interrupt (via SCLP) to be delivered to a CPU in the wait state.
>>
>> Thank you very much for tackling this! Some remarks below...
>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    lib/s390x/sclp.c    |  11 ++--
>>>    lib/s390x/sclp.h    |   1 +
>>>    s390x/Makefile      |   1 +
>>>    s390x/firq.c        | 122 ++++++++++++++++++++++++++++++++++++++++++++
>>>    s390x/unittests.cfg |  10 ++++
>>>    5 files changed, 142 insertions(+), 3 deletions(-)
>>>    create mode 100644 s390x/firq.c
>>>
>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>> index 0272249..33985eb 100644
>>> --- a/lib/s390x/sclp.c
>>> +++ b/lib/s390x/sclp.c
>>> @@ -60,9 +60,7 @@ void sclp_setup_int(void)
>>>    void sclp_handle_ext(void)
>>>    {
>>>    	ctl_clear_bit(0, CTL0_SERVICE_SIGNAL);
>>> -	spin_lock(&sclp_lock);
>>> -	sclp_busy = false;
>>> -	spin_unlock(&sclp_lock);
>>> +	sclp_clear_busy();
>>>    }
>>>    
>>>    void sclp_wait_busy(void)
>>> @@ -89,6 +87,13 @@ void sclp_mark_busy(void)
>>>    	}
>>>    }
>>>    
>>> +void sclp_clear_busy(void)
>>> +{
>>> +	spin_lock(&sclp_lock);
>>> +	sclp_busy = false;
>>> +	spin_unlock(&sclp_lock);
>>> +}
>>> +
>>>    static void sclp_read_scp_info(ReadInfo *ri, int length)
>>>    {
>>>    	unsigned int commands[] = { SCLP_CMDW_READ_SCP_INFO_FORCED,
>>> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
>>> index 61e9cf5..fead007 100644
>>> --- a/lib/s390x/sclp.h
>>> +++ b/lib/s390x/sclp.h
>>> @@ -318,6 +318,7 @@ void sclp_setup_int(void);
>>>    void sclp_handle_ext(void);
>>>    void sclp_wait_busy(void);
>>>    void sclp_mark_busy(void);
>>> +void sclp_clear_busy(void);
>>>    void sclp_console_setup(void);
>>>    void sclp_print(const char *str);
>>>    void sclp_read_info(void);
>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>> index f95f2e6..1e567c1 100644
>>> --- a/s390x/Makefile
>>> +++ b/s390x/Makefile
>>> @@ -25,6 +25,7 @@ tests += $(TEST_DIR)/uv-host.elf
>>>    tests += $(TEST_DIR)/edat.elf
>>>    tests += $(TEST_DIR)/mvpg-sie.elf
>>>    tests += $(TEST_DIR)/spec_ex-sie.elf
>>> +tests += $(TEST_DIR)/firq.elf
>>>    
>>>    tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>>    ifneq ($(HOST_KEY_DOCUMENT),)
>>> diff --git a/s390x/firq.c b/s390x/firq.c
>>> new file mode 100644
>>> index 0000000..1f87718
>>> --- /dev/null
>>> +++ b/s390x/firq.c
>>> @@ -0,0 +1,122 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Floating interrupt tests.
>>> + *
>>> + * Copyright 2021 Red Hat Inc
>>> + *
>>> + * Authors:
>>> + *    David Hildenbrand <david@redhat.com>
>>> + */
>>> +#include <libcflat.h>
>>> +#include <asm/asm-offsets.h>
>>> +#include <asm/interrupt.h>
>>> +#include <asm/page.h>
>>> +#include <asm-generic/barrier.h>
>>> +
>>> +#include <sclp.h>
>>> +#include <smp.h>
>>> +#include <alloc_page.h>
>>> +
>>> +static void wait_for_sclp_int(void)
>>> +{
>>> +	/* Enable SCLP interrupts on this CPU only. */
>>> +	ctl_set_bit(0, CTL0_SERVICE_SIGNAL);
>>> +
>>> +	/* Enable external interrupts and go to the wait state. */
>>> +	wait_for_interrupt(PSW_MASK_EXT);
>>> +}
>>
>> What happens if the CPU got an interrupt? Should there be a "while (true)"
> 
> it should not get any interrupts, but if it does anyway...
> 
>> at the end of the function to avoid that the CPU ends up crashing at the end
>> of the function?
> 
> ... we have this in smp_cpu_setup_state, after the call to the actual
> function body:
> 
> /* If the function returns, just loop here */
> 0:      j       0
> 
> so if the function returns, it will hang in there anyway

Ah, great, so we're fine indeed!

  Thomas

