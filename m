Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB890206CCA
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2020 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbgFXGpO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 24 Jun 2020 02:45:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389227AbgFXGpO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 02:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592981113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZ59dMrcCMEt2xju0yrJ58giI7+PBEke5uneE3q+nqM=;
        b=UUNu3W6BIoHEXroCRmRES9OY4NB7bocb0vhuqYi4hwzkVG4snUlINFFfGwFQHG542c5OFk
        84tGPk5FUuGGfg52OzvCxh2wQu3HBrlrjduP2KcjH5v3KWprcLJ6BnaWa+oyXphK4V+nJk
        sHesQBGIa5q4D8r3CnxECOxzVY9VeWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-7I9BkGZKMEG8noI3qbHkjQ-1; Wed, 24 Jun 2020 02:45:10 -0400
X-MC-Unique: 7I9BkGZKMEG8noI3qbHkjQ-1
Received: by mail-wr1-f69.google.com with SMTP id o25so2032942wro.16
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2020 23:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZ59dMrcCMEt2xju0yrJ58giI7+PBEke5uneE3q+nqM=;
        b=QrrdHihcuXRdlwhaLBKoanyK4JRW40r3TBdRm0IXrKdKp2v8GbQyRdHz2Zz764sT6t
         Q6euIsZJu0VJnq485R5mvU5hSd96jw8qf9q6LyaCPCkdAoGhA9fx3dzrIeyNZcFLRm9T
         AFycLzGsZzWjct6aCwRiWcDiNT25iYW/6DQHPfuN5sfw9VC8CVgXbimE2gZAeSffRaJI
         pvroxlUaO4Olbr6VNyK/E7Plj1xr1iUmnUzcZ4hRKLKfvDRmsQrkUTeGFZsmo4ATV2S3
         mCAXQ1OZLxM5K4NgGYeof4F07Igbhhr7ztAsQAZZz17Knv4wCvp/DKzBPek7SkIFHmMl
         nngQ==
X-Gm-Message-State: AOAM533JYNRsw+BXKlcMWBdbLWSDT0LnZj2WvFwiWTNWt85cF/y77v5a
        sJtyKeeAayrd/CCl6pIexnxniVcU6dYBkkY3jNAoYLuFK99LhpapiO+swTzUt4e2zQNTcd3JC0S
        4jZgpqLQzAxT/pxvwQiFdtA==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr25962239wma.66.1592981108867;
        Tue, 23 Jun 2020 23:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMXhCCx7l+MF5swaHD+KvMstBu8/FWEBhX9IfD+hyk+lEneLcjsCv+2Y48HR+WDxmoO+gR9A==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr25962215wma.66.1592981108602;
        Tue, 23 Jun 2020 23:45:08 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id c70sm6535302wme.32.2020.06.23.23.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 23:45:08 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 5.8
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20200623092341.10348-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c3afcb4-5671-f8d6-2a89-8ed69cff5e1f@redhat.com>
Date:   Wed, 24 Jun 2020 08:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623092341.10348-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/06/20 11:23, Janosch Frank wrote:
> Hi Paolo,
> 
> please pull this fix reducing the number of (currently unused) iopins
> for kvm/master.
> 
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-5.8-3
> 
> for you to fetch changes up to 774911290c589e98e3638e73b24b0a4d4530e97c:
> 
>   KVM: s390: reduce number of IO pins to 1 (2020-06-18 09:48:19 +0200)
> 
> ----------------------------------------------------------------
> The current number of KVM_IRQCHIP_NUM_PINS results in an order 3
> allocation (32kb) for each guest start/restart which can result in OOM
> killer activity when kernel memory is fragmented enough.
> 
> This fix reduces the number of iopins as s390 doesn't use them, hence
> reducing the memory footprint.
> 
> ----------------------------------------------------------------
> 
> Christian Borntraeger (1):
>   KVM: s390: reduce number of IO pins to 1
> 
>  arch/s390/include/asm/kvm_host.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Pulled, thanks.  Unfortunately this missed my 5.8-rc3 pull request by a
day, but at least it's safe and sound in kvm/master.

Paolo

