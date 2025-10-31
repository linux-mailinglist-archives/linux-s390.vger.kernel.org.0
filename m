Return-Path: <linux-s390+bounces-14404-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4DC2438C
	for <lists+linux-s390@lfdr.de>; Fri, 31 Oct 2025 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C562FFF
	for <lists+linux-s390@lfdr.de>; Fri, 31 Oct 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC07329E7C;
	Fri, 31 Oct 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOqbRqzG"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB031B116
	for <linux-s390@vger.kernel.org>; Fri, 31 Oct 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903424; cv=none; b=GZdo1NjSjnuplS0SmOaNEpaYvy4FWVxzSdaZSCLcIjPmgl+9aq48OUNXVHBKv5FOXsqpI4vtfwNPCFhZyAvu/H77kGDte9x/qmHNoulti4M0dzeuo+gkJ9PuzfJrOQkZMxG52JkbLIj7uYQ4J7Ic9Z14fU1nly2PlN01i6Ajnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903424; c=relaxed/simple;
	bh=gZqjHrpbj9/9pIcF4MRm8B3Cv87SioXPACLEDl5DzKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR5mlDihdMXpRREONhqMG+mjc2GSNu3C9ysF99GUQm63KxAS3IHj/aAHZ1sfmogbM3FoXdgynKRSJDx+VKtYL1a0IbUsU2b8+dzfrE9H4XhZxndLSvl4DB6IM1rL3HvzQtH43jJz91W9/z6TpcoGCmPeW3zC0RcfWsYZwDStjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOqbRqzG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761903420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZK8Ouv8I8TiWe+PWg/oLKfkG54ZgIWJkAoluY9LrJLo=;
	b=KOqbRqzGz023xqp7y9Zv5RG/JFMbpRm0d1BoGIpZuWQTv49P++NWcAJqj0AH/9y2EF2Jw3
	7S60wgb3dPb0xEkImMFE6+u/Rmr/Xl+T7TCwy7uLh6frBUMXlFsPqdXwFny8fllWqcOHMC
	UqG1SE1YYzqE8pEgYdrBtlTnS9Y5P44=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-jEYuR6CdO4GFUQlECd3OdQ-1; Fri, 31 Oct 2025 05:36:59 -0400
X-MC-Unique: jEYuR6CdO4GFUQlECd3OdQ-1
X-Mimecast-MFC-AGG-ID: jEYuR6CdO4GFUQlECd3OdQ_1761903418
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429b7b46eebso1761946f8f.2
        for <linux-s390@vger.kernel.org>; Fri, 31 Oct 2025 02:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903418; x=1762508218;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK8Ouv8I8TiWe+PWg/oLKfkG54ZgIWJkAoluY9LrJLo=;
        b=OC3nUYdtVDmVTTybMuyZqTPa6rn0luSYT37H82i9IqMHkhUT/a7BZmLp69FLMWBY2v
         sq70dWVtVaB6MJy4By8DFwzKUvNN2wRkbZpROrnpxm/80RA8CKLM1BZLsX8esYFC7ffJ
         1bdedSDsQq3dnKu3hroFIc2KvWKgHQs+Ciqxebk3gmF4bDBGC3QXoJ3lAl04QuMU5rcF
         89E6zpMEOZCN6THl1Jouwb9zlh2HONVNP/J46u4Jkgvp0Ph7LRpFcWTMz1H5lP/ed9Zs
         hqNs5/5SBTnE4ZD+z1MZ1r06atsgJ/NjNo8wlncCN4sv5Oc6EfFi+HvJL/l4XqiahAFC
         dUgQ==
X-Gm-Message-State: AOJu0YytFmWTJDsTlodLg87V5SGY9qBPwbDvg8GMSwhdNbV+ReGdbsSH
	LQhINV9enGnQ062XsmZfvzVAkdUftHBCNtxvz7GPeTrcKXL+FxNuosRUdM9Oemo7Au1gxf8ngtg
	LREpfOxGZh2322RZyUeZRIa6giB8o6QTA5OjAcOdlbK1ywSYGOmKp1gXboqTVr00=
X-Gm-Gg: ASbGncsbi0/1QbPAqR0CTvpeAJjj5C09+f0KnWxdkTCL1EB5jqYV7qG3mol0waI2Sga
	E20zkfjspojPPtjXSGQcxNGf2oqp/5s13J9TPRM3A56ncgXiLUna5MU1bmyENR0X1n3BMC10qxu
	CblCsrqXsNFmL3ErNuCpXnE/8c3zeQCdkWhRQqdGBy3B5mPse34pp1MMOc4gXRSntVxu0W8jMTP
	W3tRhl49jwkxvN5QlXxSDj+8rX6eAdIDa+WmjWtHLdjIs+0a1NBg7Dv3lcrNWk/EjuE+oZ80Hid
	b1fA0Q+0m06M/L6dWY/NLiQaJAiXPddiWlno7t77idv4iyPxbAi4a+EYzR1pOpWoUjwCQyE=
X-Received: by 2002:a05:6000:220f:b0:428:3f7c:bd0c with SMTP id ffacd0b85a97d-429bd6a4dd8mr2499285f8f.31.1761903417616;
        Fri, 31 Oct 2025 02:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQEIdn102kylfuS3zKhF8SGLW6+1R0H/14WqOh293qg7aPSzlR3v/ByyyuOMd9ODc+UOlK+g==
X-Received: by 2002:a05:6000:220f:b0:428:3f7c:bd0c with SMTP id ffacd0b85a97d-429bd6a4dd8mr2499256f8f.31.1761903417127;
        Fri, 31 Oct 2025 02:36:57 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0325sm2488486f8f.29.2025.10.31.02.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:36:56 -0700 (PDT)
Message-ID: <a3020cd1-1757-4ef8-8555-ca4f79bfb317@redhat.com>
Date: Fri, 31 Oct 2025 10:36:55 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: Add capability that forwards operation
 exceptions
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <20251029130744.6422-1-frankja@linux.ibm.com>
 <8c25cc75-021d-4199-96de-83e06e16a514@redhat.com>
 <5255f540-e723-47e5-8035-387bea9f6fa3@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5255f540-e723-47e5-8035-387bea9f6fa3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/2025 09.45, Janosch Frank wrote:
> On 10/30/25 08:10, Thomas Huth wrote:
>> On 29/10/2025 14.04, Janosch Frank wrote:
>>> Setting KVM_CAP_S390_USER_OPEREXEC will forward all operation
>>> exceptions to user space. This also includes the 0x0000 instructions
>>> managed by KVM_CAP_S390_USER_INSTR0. It's helpful if user space wants
>>> to emulate instructions which do not (yet) have an opcode.
>>>
>>> While we're at it refine the documentation for
>>> KVM_CAP_S390_USER_INSTR0.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ...
>>> +7.45 KVM_CAP_S390_USER_OPEREXEC
>>> +----------------------------
>>> +
>>> +:Architectures: s390
>>> +:Parameters: none
>>> +
>>> +When this capability is enabled KVM forwards all operation exceptions
>>> +that it doesn't handle itself to user space. This also includes the
>>> +0x0000 instructions managed by KVM_CAP_S390_USER_INSTR0. This is
>>> +helpful if user space wants to emulate instructions which do not (yet)
>>> +have an opcode.
>>
>> "which do not (yet) have an opcode" sounds a little bit weird. Maybe rather:
>> "which are not (yet) implemented in the current CPU" or so?
> 
> How about:
> ...which are not (yet) implemented in hardware.

Sounds good!


>>> @@ -921,6 +922,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct 
>>> kvm_enable_cap *cap)
>>>            VM_EVENT(kvm, 3, "ENABLE: CAP_S390_CPU_TOPOLOGY %s",
>>>                 r ? "(not available)" : "(success)");
>>>            break;
>>> +    case KVM_CAP_S390_USER_OPEREXEC:
>>> +        VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_OPEREXEC");
>>> +        kvm->arch.user_operexec = 1;
>>> +        icpt_operexc_on_all_vcpus(kvm);
>>
>> Maybe check cap->flags here and return with an error if any flag is set? ...
>> otherwise, if we ever add flags here, userspace cannot check whether the
>> kernel accepted a flag or not.
> 
> Check the top of the function :)

Ah, I missed that, so it should already be fine!


>>> + * Run all tests above.
>>> + *
>>> + * Enablement after VCPU has been added is automatically tested since
>>> + * we enable the capability after VCPU creation.
>>> + */
>>> +static struct testdef {
>>> +    const char *name;
>>> +    void (*test)(void);
>>> +} testlist[] = {
>>> +    { "instr0", test_user_instr0 },
>>> +    { "operexec", test_user_operexec },
>>> +    { "operexec_combined", test_user_operexec_combined},
>>> +};
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +    int idx;
>>> +
>>> +    TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_USER_INSTR0));
>>> +
>>> +    ksft_print_header();
>>> +    ksft_set_plan(ARRAY_SIZE(testlist));
>>> +    for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
>>> +        testlist[idx].test();
>>> +        ksft_test_result_pass("%s\n", testlist[idx].name);
>>> +    }
>>> +    ksft_finished();
>>> +}
>>
>> You could likely use the KVM_ONE_VCPU_TEST() macro and test_harness_run() to
>> get rid of the boilerplate code here.
> 
> Is there a general directive to use KVM_ONE_VCPU_TEST?

Certainly not from my side!
(but Sean might have a different opinion on this topic ;-))

> To be honest I prefer the look as is since it doesn't hide things behind 
> macros and 95% of our tests use it.

Fine for me, too.

  Thomas


