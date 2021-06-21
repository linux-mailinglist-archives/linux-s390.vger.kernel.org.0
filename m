Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C43AEA10
	for <lists+linux-s390@lfdr.de>; Mon, 21 Jun 2021 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUNbO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Jun 2021 09:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229876AbhFUNbO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624282139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7fgQekaaOnEF+eLGP72M2n1gjwZcEJto/FHTEMl2no=;
        b=J/mmmQYCPnmrnNXiRCHKPB6YM880ea/z5r/pT1I5MalwAlaxh1QfNuhniEJreAeOr2Cl7/
        ln+kfyMFJJuuCtW9C1GCKBdnA5x5W5m8dAj+1ZizlF0f2jdSBO14Q46daRjr6/Dg3Wp4Ol
        MIU1o2xKNt3DLIMkvGMIHBlPS+/yJ04=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-vXnt35khNe-WRSiHLXYZjw-1; Mon, 21 Jun 2021 09:28:58 -0400
X-MC-Unique: vXnt35khNe-WRSiHLXYZjw-1
Received: by mail-wm1-f72.google.com with SMTP id w186-20020a1cdfc30000b02901ced88b501dso5831940wmg.2
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 06:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7fgQekaaOnEF+eLGP72M2n1gjwZcEJto/FHTEMl2no=;
        b=YXW2SU9gF1E3uykyXP8VF7OCN9yWtF/TC82QC/bF4R2hNy1irSI2uszTCYpk04OnZG
         1msrhWK73H/KDv+MLZ3x2cnUPL5A17d3Xh/dRmArywxBOq0gwrLSpKZwdQ9wUqT4fl/3
         +ButrRQIy97YK95Vank0HnK2jnqdcMYAi1S1ALIAICPOgelRGpHhIxxBMQcGxbyHrEnl
         7PW+n8SXjn9CbEOsylS0bxcADqpr7PLTKVcndH/mQ1dTG23HnNDeF2uR7b9Z6+y7u5Af
         Zs8JIf1RmruhSDTKtolSOfQVb3nOVmTMpuxejSLUrEETBh15APYeduEPkDaMWU4nqmkP
         j2tg==
X-Gm-Message-State: AOAM533+x8nkd8I1VhIeTyXEZLM4AUp6roCOh3PKg4au3XJeBzusiKkO
        70fGDf1wDbaXPxdBvjQx4FB8bbAqCoK268M6eNEhBbheQYj2rMUVKIwueh7pO200sgvx5w2xQ5Y
        YCbWzPC68T/Ea4Uqm2RtYYw==
X-Received: by 2002:adf:de12:: with SMTP id b18mr21514800wrm.322.1624282137462;
        Mon, 21 Jun 2021 06:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcR+nZwdksBC3fleQjPiL8JPww8Zzi7Cjn6MK+YRLVV07KMdA8X2xavHYMS4VlU7AA0mx71A==
X-Received: by 2002:adf:de12:: with SMTP id b18mr21514782wrm.322.1624282137291;
        Mon, 21 Jun 2021 06:28:57 -0700 (PDT)
Received: from thuth.remote.csb (pd9575fcd.dip0.t-ipconnect.de. [217.87.95.205])
        by smtp.gmail.com with ESMTPSA id v15sm19892888wmj.39.2021.06.21.06.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 06:28:56 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 1/2] s390x: Add guest snippet support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210520094730.55759-1-frankja@linux.ibm.com>
 <20210520094730.55759-2-frankja@linux.ibm.com>
 <b5171773-afb6-e148-a82f-ea78877206ce@redhat.com>
 <d20e7f88-dcca-67ca-17e0-7c45982aa5ff@linux.ibm.com>
 <304a297a-c366-9d61-9d13-fc1f86dd4f50@redhat.com>
 <19e99dfe-6730-194b-a0c5-87455f446625@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <5149db0e-8372-6054-da0d-fc8f85ac4038@redhat.com>
Date:   Mon, 21 Jun 2021 15:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <19e99dfe-6730-194b-a0c5-87455f446625@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/06/2021 14.39, Janosch Frank wrote:
> On 6/21/21 2:32 PM, Thomas Huth wrote:
>> On 21/06/2021 14.19, Janosch Frank wrote:
>>> On 6/21/21 12:10 PM, Thomas Huth wrote:
>>>> On 20/05/2021 11.47, Janosch Frank wrote:
>>>>> Snippets can be used to easily write and run guest (SIE) tests.
>>>>> The snippet is linked into the test binaries and can therefore be
>>>>> accessed via a ptr.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>     .gitignore                |  2 ++
>>>>>     s390x/Makefile            | 28 ++++++++++++++++++---
>>>>>     s390x/snippets/c/cstart.S | 13 ++++++++++
>>>>>     s390x/snippets/c/flat.lds | 51 +++++++++++++++++++++++++++++++++++++++
>>>>>     4 files changed, 91 insertions(+), 3 deletions(-)
>>>>>     create mode 100644 s390x/snippets/c/cstart.S
>>>>>     create mode 100644 s390x/snippets/c/flat.lds
>>>>>
>>>>> diff --git a/.gitignore b/.gitignore
>>>>> index 784cb2dd..29d3635b 100644
>>>>> --- a/.gitignore
>>>>> +++ b/.gitignore
>>>>> @@ -22,3 +22,5 @@ cscope.*
>>>>>     /api/dirty-log
>>>>>     /api/dirty-log-perf
>>>>>     /s390x/*.bin
>>>>> +/s390x/snippets/*/*.bin
>>>>> +/s390x/snippets/*/*.gbin
>>>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>>>> index 8de926ab..fe267011 100644
>>>>> --- a/s390x/Makefile
>>>>> +++ b/s390x/Makefile
>>>>> @@ -75,11 +75,33 @@ OBJDIRS += lib/s390x
>>>>>     asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
>>>>>     
>>>>>     FLATLIBS = $(libcflat)
>>>>> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>>>> +
>>>>> +SNIPPET_DIR = $(TEST_DIR)/snippets
>>>>> +
>>>>> +# C snippets that need to be linked
>>>>> +snippets-c =
>>>>> +
>>>>> +# ASM snippets that are directly compiled and converted to a *.gbin
>>>>> +snippets-a =
>>>>
>>>> Could you please call this snippets-s instead of ...-a ? The -a suffix looks
>>>> like an archive to me otherwise.
>>>
>>> Sure
>>>
>>>>
>>>>> +snippets = $(snippets-a)$(snippets-c)
>>>>
>>>> Shouldn't there be a space between the two?
>>>
>>> Yes, already fixed that a long while ago
>>> I thought I had sent out a new version already, maybe that was an
>>> illusion as I can't seem to find it right now.
>>>
>>>>
>>>>> +snippets-o += $(patsubst %.gbin,%.o,$(snippets))
>>>>> +
>>>>> +$(snippets-a): $(snippets-o) $(FLATLIBS)
>>>>> +	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
>>>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>>>> +
>>>>> +$(snippets-c): $(snippets-o) $(SNIPPET_DIR)/c/cstart.o  $(FLATLIBS)
>>>>> +	$(CC) $(LDFLAGS) -o $@ -T $(SNIPPET_DIR)/c/flat.lds \
>>>>> +		$(filter %.o, $^) $(FLATLIBS)
>>>>> +	$(OBJCOPY) -O binary $@ $@
>>>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>>>> +
>>>>> +%.elf: $(snippets) %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>>>>     	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
>>>>>     		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
>>>>>     	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
>>>>> -		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
>>>>> +		$(filter %.o, $^) $(FLATLIBS) $(snippets) $(@:.elf=.aux.o)
>>>>
>>>> Does this link the snippets into all elf files? ... wouldn't it be better to
>>>> restrict it somehow to the files that really need them?
>>>
>>> Yes it does.
>>> I'd like to avoid having to specify a makefile rule for every test that
>>> uses snippets as we already have more than the mvpg one in the queue.
>>>
>>> So I'm having Steffen looking into a solution for this problem. My first
>>> idea was to bring the used snippets into the unittests.cfg but I
>>> disliked that we then would have compile instructions in another file.
>>> Maybe there's a way to include that into the makefile in a clever way?
>>
>> I haven't tried, but maybe you could replace the $(snippets) in the last
>> line with
>>
>>    $(wildcard snippets/$@.gbin)
>>
>> or something similar?
> 
> That starts falling apart when multiple tests use the same snippet, no?

That's true ... Maybe something like:

  $(filter %.gbin,$^)

?

  Thomas

