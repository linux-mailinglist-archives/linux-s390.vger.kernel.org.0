Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD13EFFBD
	for <lists+linux-s390@lfdr.de>; Wed, 18 Aug 2021 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHRI6Y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Aug 2021 04:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231241AbhHRI6U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 04:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629277065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS5Oo5yG40hvfsBpZlz+cQmBdONR4SqLP55eL+HtH88=;
        b=cSCylv0kfT+1p5U6oSdJR0K1W4lPWyD1+hnpHnLbtdlEcL2bCNMu2aHcuT45D1IJFNY5LS
        L/D89KS0yrK0E3OYw8+rsAV0qxSqyVC7YUCREunqX+Qj0ik/rouYYhtauUv1HFTVO8S+rk
        0Oc9yIPFeQIFrrZESOqBoJ9VBKfXydg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-oQNKb8_3MF2nCesaiCM6bw-1; Wed, 18 Aug 2021 04:57:43 -0400
X-MC-Unique: oQNKb8_3MF2nCesaiCM6bw-1
Received: by mail-ej1-f69.google.com with SMTP id e15-20020a1709061fcf00b005bd9d618ea0so613122ejt.13
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 01:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jS5Oo5yG40hvfsBpZlz+cQmBdONR4SqLP55eL+HtH88=;
        b=cSdFceQ+bGCUxcIOFJg0kg97lE8ygQtVZuCRdio6dXVtDuvjlTIEIsaBQdnjNTd6I3
         CfsnzRJ+VQt9fIuwoZSp56QQUlvTMFd96qXxVJs8OJmHEwOxlsbOY1qiLLkmCbkALpdG
         +ss8lBG/kszNBxEetWP63fdTKC0bFdF/06mwnS22D11HpCvxvrQaruxOubeKGbNobjvi
         sYFa1AJPd0EbTDbEssGf22vMsix796kRih5T7/eWz3feZqOwACxWn8mWwVb5qR2sPTQs
         aTdB+RCphDUiEwIpghqNiTQLVQN4IUNU8AEK5iu7Aeap9HNya+ayOnsTVaN0hKpSJkPX
         ICPA==
X-Gm-Message-State: AOAM532tOR7e92XuzQT/b8Qng5ZgbEISeth2tI5q+tVZomdxNqDbyT9S
        dRcMbxUCa3wfeTdUM8LgNa9vCsdGUF1YH39FQ8CRMX1kqx0z6WdT0uipK/UX6pqgw6JTQLt2HXZ
        2sYeeqZAG6VWun6nXtRABEQ==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr8864089edb.240.1629277062710;
        Wed, 18 Aug 2021 01:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuZrPP72Z6Kp1pulO+le0Ubk5WDCJty44KO5sKHwMCufqo3iEffftwcerpwf9X2f6Zg5xCEg==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr8864080edb.240.1629277062490;
        Wed, 18 Aug 2021 01:57:42 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id q21sm1721005ejs.43.2021.08.18.01.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:57:41 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/8] s390x: lib: Extend bitops
To:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        cohuck@redhat.com
References: <20210813073615.32837-1-frankja@linux.ibm.com>
 <20210813073615.32837-2-frankja@linux.ibm.com>
 <20210813103240.33710ea6@p-imbrenda>
 <e0bcb199-7254-01bb-baee-7de83b62495a@linux.ibm.com>
 <de5b6d16-9ec1-5d77-00ac-61305d90851a@redhat.com>
 <9d6730f4-21a2-d161-d609-557da2254909@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <c72191c5-64d0-e66e-6519-b0df51023338@redhat.com>
Date:   Wed, 18 Aug 2021 10:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9d6730f4-21a2-d161-d609-557da2254909@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/08/2021 10.39, Janosch Frank wrote:
> On 8/18/21 10:20 AM, Thomas Huth wrote:
>> On 13/08/2021 13.31, Janosch Frank wrote:
>>> On 8/13/21 10:32 AM, Claudio Imbrenda wrote:
>>>> On Fri, 13 Aug 2021 07:36:08 +0000
>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>
>>>>> Bit setting and clearing is never bad to have.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>    lib/s390x/asm/bitops.h | 102
>>>>> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 102
>>>>> insertions(+)
>>>>>
>>>>> diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
>>>>> index 792881ec..f5612855 100644
>>>>> --- a/lib/s390x/asm/bitops.h
>>>>> +++ b/lib/s390x/asm/bitops.h
>>>>> @@ -17,6 +17,78 @@
>>>>>    
>>>>>    #define BITS_PER_LONG	64
>>>>>    
>>>>> +static inline unsigned long *bitops_word(unsigned long nr,
>>>>> +					 const volatile unsigned
>>>>> long *ptr) +{
>>>>> +	unsigned long addr;
>>>>> +
>>>>> +	addr = (unsigned long)ptr + ((nr ^ (nr & (BITS_PER_LONG -
>>>>> 1))) >> 3);
>>>>> +	return (unsigned long *)addr;
>>>>
>>>> why not just
>>>>
>>>> return ptr + (nr / BITS_PER_LONG);
>>>>
>>>>> +}
>>>>> +
>>>>> +static inline unsigned long bitops_mask(unsigned long nr)
>>>>> +{
>>>>> +	return 1UL << (nr & (BITS_PER_LONG - 1));
>>>>> +}
>>>>> +
>>>>> +static inline uint64_t laog(volatile unsigned long *ptr, uint64_t
>>>>> mask) +{
>>>>> +	uint64_t old;
>>>>> +
>>>>> +	/* load and or 64bit concurrent and interlocked */
>>>>> +	asm volatile(
>>>>> +		"	laog	%[old],%[mask],%[ptr]\n"
>>>>> +		: [old] "=d" (old), [ptr] "+Q" (*ptr)
>>>>> +		: [mask] "d" (mask)
>>>>> +		: "memory", "cc" );
>>>>> +	return old;
>>>>> +}
>>>>
>>>> do we really need the artillery (asm) here?
>>>> is there a reason why we can't do this in C?
>>>
>>> Those are the interlocked/atomic instructions and even though we don't
>>> exactly need them right now I wanted to add them for completeness.
>>
>> I think I agree with Claudio - unless we really need them, we should not
>> clog the sources with arbitrary inline assembly functions.
> 
> Alright I can trim it down
> 
>>
>>> We might be able to achieve the same via compiler functionality but this
>>> is not my expertise. Maybe Thomas or David have a few pointers for me?
>>
>> I'm not an expert with atomic builtins either, but what's the point of this
>> at all? Loading a value and OR-ing something into the value in one go?
>> What's that good for?
> 
> Well it's a block-concurrent interlocked-update load, or and store.
> I.e. it loads the data from the ptr and copies it into [old] then ors
> the mask and stores it back to the ptr address.
> 
> The instruction name "load and or" does not represent the full actions
> of the instruction.

Ok, thanks, that makes more sense now, but you could at least have mentioned 
this in the comment that you added in front of it :-)

Anyway, I guess it's easier to use the builtin atomic functions like 
__atomic_or_fetch() for stuff like this in case we ever need it.

  Thomas

