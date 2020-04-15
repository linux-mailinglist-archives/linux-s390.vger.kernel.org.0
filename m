Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449AE1A9686
	for <lists+linux-s390@lfdr.de>; Wed, 15 Apr 2020 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408061AbgDOIaS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Apr 2020 04:30:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441175AbgDOIaP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Apr 2020 04:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586939412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLmrOkcXJQ/8f3TsPjBB59Qp6PFUF6WHach7rOTidPU=;
        b=FxA3WjYN4kwdXtLZDi2sc6x3ZU5WbK08q3wSXfSNfwlJh8I9JUucbr+Ky/O6lCU29tPkrD
        suFFphuV76VWsPfkV4GzEkD9xxn1NDjo/VvCNFoYkitfcX3Rd5CyqWOe38G8lmreCdOdRd
        C3uKHJGolCEP15tNQsJHXogFWrkxsOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-5xC7MWu3PZWEoTMCbg_RJA-1; Wed, 15 Apr 2020 04:30:10 -0400
X-MC-Unique: 5xC7MWu3PZWEoTMCbg_RJA-1
Received: by mail-wm1-f71.google.com with SMTP id n127so4669067wme.4
        for <linux-s390@vger.kernel.org>; Wed, 15 Apr 2020 01:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLmrOkcXJQ/8f3TsPjBB59Qp6PFUF6WHach7rOTidPU=;
        b=oV20YhWhenSIB5/ofDFU1AD415PFsEPrcSyL7au06wxNPBK+sEPITdkKUo7VXowCb4
         sml4LPDnk93yxVqHNV2BoyObxeujnDoKi8s0NanbYSqtbmeCOnLDqpM+FYzZAeJXcOdU
         XetaLoChkFVprrazAf6VpAOKlvJVuiPq3NhktD1ArYG2FfNtiwB6UlDCv3a5elzuR5y7
         rdANGy83juntlkQMios8Mqo1li7o8Yl8RD2IkYwkx8UAwa36u6/gFuT8g7pLWv3GVQVt
         7RMu+LLMlis2i/m8zbBXnIQj1MLUSfZEFlmBXedsAO5cvvs2aEaoh0VUWFEKgf2/hhpx
         Xx4Q==
X-Gm-Message-State: AGi0PubH5esloCrWWNtQJkdaI5uEp+5G8wEjEisL7pF102JQJaj+qMv6
        9mgCPaKk4jXhvy+3dApvPa6/n08V8nINyC48Lsu8W8cAqMdhkVMboCHRap5Lmhq8944FSGzVTHu
        iOdc0bBoq405GOehG28DYJQ==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr4126793wmf.187.1586939409338;
        Wed, 15 Apr 2020 01:30:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1/GFDfyQOLK5J6+00PCnZPj8fmTN9rFZPV07c4zGKdQlKsQOx+NrwNSeq7rAzMZDiU7ufeQ==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr4126760wmf.187.1586939409106;
        Wed, 15 Apr 2020 01:30:09 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.238])
        by smtp.gmail.com with ESMTPSA id g25sm8724053wmh.24.2020.04.15.01.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:30:08 -0700 (PDT)
Subject: Re: [PATCH v2] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org
References: <20200414155625.20559-1-eesposit@redhat.com>
 <b479e7ff-4534-5ced-e19b-2a2914905a8b@amsat.org>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <992ede27-3eae-f2da-ad38-1d3498853ad2@redhat.com>
Date:   Wed, 15 Apr 2020 10:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b479e7ff-4534-5ced-e19b-2a2914905a8b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 4/15/20 8:36 AM, Philippe Mathieu-Daudé wrote:
> On 4/14/20 5:56 PM, Emanuele Giuseppe Esposito wrote:
>> The macros VM_STAT and VCPU_STAT are redundantly implemented in multiple
>> files, each used by a different architecure to initialize the debugfs
>> entries for statistics. Since they all have the same purpose, they can be
>> unified in a single common definition in include/linux/kvm_host.h
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   arch/arm64/kvm/guest.c    |  23 ++---
>>   arch/mips/kvm/mips.c      |  61 ++++++------
>>   arch/powerpc/kvm/book3s.c |  61 ++++++------
>>   arch/powerpc/kvm/booke.c  |  41 ++++----
>>   arch/s390/kvm/kvm-s390.c  | 203 +++++++++++++++++++-------------------
>>   arch/x86/kvm/x86.c        |  80 +++++++--------
>>   include/linux/kvm_host.h  |   5 +
>>   7 files changed, 231 insertions(+), 243 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 23ebe51410f0..8417b200bec9 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -29,20 +29,17 @@
>>   
>>   #include "trace.h"
>>   
>> -#define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
>> -#define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
>> -
>>   struct kvm_stats_debugfs_item debugfs_entries[] = {
>> -	VCPU_STAT(halt_successful_poll),
>> -	VCPU_STAT(halt_attempted_poll),
>> -	VCPU_STAT(halt_poll_invalid),
>> -	VCPU_STAT(halt_wakeup),
>> -	VCPU_STAT(hvc_exit_stat),
>> -	VCPU_STAT(wfe_exit_stat),
>> -	VCPU_STAT(wfi_exit_stat),
>> -	VCPU_STAT(mmio_exit_user),
>> -	VCPU_STAT(mmio_exit_kernel),
>> -	VCPU_STAT(exits),
>> +	VCPU_STAT("halt_successful_poll", halt_successful_poll),
>> +	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
>> +	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
>> +	VCPU_STAT("halt_wakeup", halt_wakeup),
>> +	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
>> +	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
>> +	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
>> +	VCPU_STAT("mmio_exit_user", mmio_exit_user),
>> +	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
>> +	VCPU_STAT("exits", exits),
>>   	{ NULL }
>>   };
> 
> Patch easily reviewed with --word-diff.
> 
> [...]
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 6d58beb65454..2e6ead872957 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1130,6 +1130,11 @@ struct kvm_stats_debugfs_item {
>>   #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>>   	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>>   
>> +#define VM_STAT(n, x, ...) 													   \
>> +	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
>> +#define VCPU_STAT(n, x, ...)												   \
> 
> Not sure while you use so many whitespaces here... (maybe Paolo can
> strip some when applying?).

I honestly am not sure why it added few more spaces than I wanted, but 
the idea was to follow the KVM_DBGFS_GET_MODE macro above and put the 
backslash at the end of the line (80th char).

> 
> Otherwise it looks nicer that v1, thanks.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
>> +
>>   extern struct kvm_stats_debugfs_item debugfs_entries[];
>>   extern struct dentry *kvm_debugfs_dir;
>>   
>>
> 

