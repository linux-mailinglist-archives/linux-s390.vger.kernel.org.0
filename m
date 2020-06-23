Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6162204EF7
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2020 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgFWKYp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 Jun 2020 06:24:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732223AbgFWKYp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 06:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592907884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0VMF+zOglKc79uK7nAPfjf+HV37t2ditCPtYi6hRnc=;
        b=fj0KjKiBRki4CRZ/41MI8NTE6klsTXqaJpu37yuRSd1wPUBqjVGdhMP8gk5cUhDLe1bMEf
        KyROxz8NyF1OMl07ij2V/gNihYJtyGFON2qreiiheOvHrVE+H1RfdX8MawFyMKPqlPA9NU
        sVlVEi4xWk6GGzeBhswX0Qb5KTuXpbc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-_Gizzx8WOsigbSlgi18mOA-1; Tue, 23 Jun 2020 06:24:42 -0400
X-MC-Unique: _Gizzx8WOsigbSlgi18mOA-1
Received: by mail-wr1-f71.google.com with SMTP id b14so14473740wrp.0
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2020 03:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0VMF+zOglKc79uK7nAPfjf+HV37t2ditCPtYi6hRnc=;
        b=uUOYt4SJ3xMoUrYbP/MxEc2Nata+YEIB27iY79vUWBEaAqScHt9mpXM2jOzFhhdIZJ
         p7UbFDtvb2SJri+3qBKx7AtRzUitoSxktcx6IYPGh5/216owFMbkUeqRt493rwa+U+3y
         vhORR4Ackpi3I550lSGtwFCAL3GGBMlfGCUmymeYyQJXH9P7+QwM6aUn0/Pf0x2G145b
         wUhtsKUlPSDduhjLvxu/mjzO8GlJnhwp/Z6Ma7NpBQAW+2YG6Xq9Hfx6tHSe1jRuhlHD
         qoTGRmTIsYIZ2PumMKOWTMn3ON84XTP2vZEE8H/fN+gagzQWS6II/glmx9vbMc1wxALl
         eWUg==
X-Gm-Message-State: AOAM532kjFofh647DWnoLcC7wg4iF2tUifGtrCCDplB3vnNGZKlktdiD
        Sv1TIKOmLbs5iiYR0PGZgip4Mvr2CjWbufA3zr+fwvzyyuoY18NjXUdHUY7BoVu0qVVKOycL6V/
        bfo1QmsXIcl4jlSwz2IzNeg==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr16454566wrx.294.1592907881329;
        Tue, 23 Jun 2020 03:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7GKxnJWV0b4Mz/7lWJjdPl3+rZwUgIO80Ac5HDjj13PmRVjDey+yK0l49hJjTmncjlmTnYw==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr16454534wrx.294.1592907881013;
        Tue, 23 Jun 2020 03:24:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id c66sm3351206wma.20.2020.06.23.03.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:24:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] clean up redundant 'kvm_run' parameters
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
        chenhuacai@gmail.com
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <fe463233-d094-fca5-b4e9-c1d97124fd69@redhat.com>
 <3a2bee8b-20b4-5d33-7d12-09c374a5afde@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bad08799-274e-0a6f-9638-92c0010b1ba1@redhat.com>
Date:   Tue, 23 Jun 2020 12:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3a2bee8b-20b4-5d33-7d12-09c374a5afde@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/06/20 12:00, Tianjia Zhang wrote:
> 
> 
> On 2020/6/23 17:42, Paolo Bonzini wrote:
>> On 27/04/20 06:35, Tianjia Zhang wrote:
>>> In the current kvm version, 'kvm_run' has been included in the
>>> 'kvm_vcpu'
>>> structure. For historical reasons, many kvm-related function parameters
>>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>>> patch does a unified cleanup of these remaining redundant parameters.
>>>
>>> This series of patches has completely cleaned the architecture of
>>> arm64, mips, ppc, and s390 (no such redundant code on x86). Due to
>>> the large number of modified codes, a separate patch is made for each
>>> platform. On the ppc platform, there is also a redundant structure
>>> pointer of 'kvm_run' in 'vcpu_arch', which has also been cleaned
>>> separately.
>>
>> Tianjia, can you please refresh the patches so that each architecture
>> maintainer can pick them up?  Thanks very much for this work!
>>
>> Paolo
>>
> 
> No problem, this is what I should do.
> After I update, do I submit separately for each architecture or submit
> them together in a patchset?

You can send them together.

Paolo

