Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30180494BDC
	for <lists+linux-s390@lfdr.de>; Thu, 20 Jan 2022 11:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiATKih (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 20 Jan 2022 05:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376326AbiATKif (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Jan 2022 05:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642675114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFpN3f0uduDA3tQ7l5sXIVy8xoN2m2qwc3s/2ZpwE2I=;
        b=CBWQbPJOD0nY8gsyaGhlSbLLEZ458+TdTU0e1WBVhpuI2tlT4GV4IcSEXYgbT4yrMBylmb
        JJr4GGUANc6xfq/29dXXryRIM+h7sVZIJ/HWXlkClPOGfE8SPKo4/VqlXdxKu1qMU9p2VR
        1FI99IIVAfOp0DpQmmnaRlZ9dy4W4cM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-u9dQgkaeMIK0p8DY-3jULw-1; Thu, 20 Jan 2022 05:38:32 -0500
X-MC-Unique: u9dQgkaeMIK0p8DY-3jULw-1
Received: by mail-wm1-f72.google.com with SMTP id o3-20020a05600c4fc300b0034aee9534bdso2579117wmq.2
        for <linux-s390@vger.kernel.org>; Thu, 20 Jan 2022 02:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sFpN3f0uduDA3tQ7l5sXIVy8xoN2m2qwc3s/2ZpwE2I=;
        b=w62tTMI2XOzVulenYtPWx+tuQ9btnjSrh/U4qcFKg7hQmXTQyOjUHUDOZcgrLs2IpT
         BwqWzbsG1si2whBYUXVSIGKNqth61sVlgnEibyoIs0ETOrCjqaQl3ZLa/3B7HqVtvtpI
         NSEso8059B/g8TBTky3yZLCeNS+vJG7rcjiwvKlQv1+8RB6fv43zDGlA/l3UFY0XNlyz
         TKh3amrV0vUZpILBew8ROHifBCixvsEgYSTsloXXASMyemqDJeWa0o+Tj8ZmAlZovCaW
         bBUwtGHGGwqJBcEC/3mlAmtxtK6DU4WbQOgVRIagtlOAuw8OahurZWuVLxOeDus9ZUlG
         oyNA==
X-Gm-Message-State: AOAM531EDxFQ/vub7roC91MHO01lqT9GRHKoyKz2U8qXjHTSjhDqWvKF
        kDpiDGwaAf7BdGlVQSPzHm9FwbnMU0I6iw71XNzTfNra5dQKXXNNT7fJY7A1IxSYdfWTkO6ZKR/
        6pTFksj3oZFI9ZQEHrwVABQ==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr3963431wrx.598.1642675111368;
        Thu, 20 Jan 2022 02:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfvIX06o0KrIvdE4knevl3OSMRO8haaYDO1DIVACVjH75Q5KDVwCs2c7eUgWYh9T6sdMZ1nw==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr3963404wrx.598.1642675111135;
        Thu, 20 Jan 2022 02:38:31 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id n10sm1005966wrf.96.2022.01.20.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 02:38:30 -0800 (PST)
Message-ID: <069c72b6-457f-65c7-652e-e6eca7235fca@redhat.com>
Date:   Thu, 20 Jan 2022 11:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 06/10] KVM: s390: Add vm IOCTL for key checked
 guest absolute memory access
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-7-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220118095210.1651483-7-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/01/2022 10.52, Janis Schoetterl-Glausch wrote:
> Channel I/O honors storage keys and is performed on absolute memory.
> For I/O emulation user space therefore needs to be able to do key
> checked accesses.
> The vm IOCTL supports read/write accesses, as well as checking
> if an access would succeed.
...
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index e3f450b2f346..dd04170287fd 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -572,6 +572,8 @@ struct kvm_s390_mem_op {
>   #define KVM_S390_MEMOP_LOGICAL_WRITE	1
>   #define KVM_S390_MEMOP_SIDA_READ	2
>   #define KVM_S390_MEMOP_SIDA_WRITE	3
> +#define KVM_S390_MEMOP_ABSOLUTE_READ	4
> +#define KVM_S390_MEMOP_ABSOLUTE_WRITE	5

Not quite sure about this - maybe it is, but at least I'd like to see this 
discussed: Do we really want to re-use the same ioctl layout for both, the 
VM and the VCPU file handles? Where the userspace developer has to know that 
the *_ABSOLUTE_* ops only work with VM handles, and the others only work 
with the VCPU handles? A CPU can also address absolute memory, so why not 
adding the *_ABSOLUTE_* ops there, too? And if we'd do that, wouldn't it be 
sufficient to have the VCPU ioctls only - or do you want to call these 
ioctls from spots in QEMU where you do not have a VCPU handle available? 
(I/O instructions are triggered from a CPU, so I'd assume that you should 
have a VCPU handle around?)

  Thomas


