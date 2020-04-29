Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC481BDB4F
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2020 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD2MD4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 29 Apr 2020 08:03:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27751 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgD2MD4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 08:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588161834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqLyCXunZj5hIFRUBscgO/EQSOL9w9OMkdGXwDOCk6M=;
        b=VNU9le3J0Fnzu7NyUHsMVo9C80npV4kOpJOAsjsilFZGH5lvXe4f8O6g2FdmJS4+8d9mbp
        CJFsy8b41E7GP+bsq0RHW6rYECUhtrWx2T1MXVyoJSW2Ho+O3Y7JVomBK4stbe11rayxRY
        LOIu95UNgm1RzaJGJ7MzZa0FhQst2Fg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-G2K0ykN5MdyQIYvrvFSoag-1; Wed, 29 Apr 2020 08:03:52 -0400
X-MC-Unique: G2K0ykN5MdyQIYvrvFSoag-1
Received: by mail-wr1-f69.google.com with SMTP id f2so1617329wrm.9
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2020 05:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PqLyCXunZj5hIFRUBscgO/EQSOL9w9OMkdGXwDOCk6M=;
        b=atO4Tm3a2/qmohG1pXTYxFYGYVCslg3dfg3x+n69I/qgKRtIA2SA8gxUWjzKDDajhE
         qNZEIYd6MmiAPvsU5lH0Av3rjyGq0F/5dc63y1HL0u7/tvgeLP8wPOZBlt+4kT40TrfE
         xX/eh8Nuy4RLgGxIXpgTQx5Zh5tocPEBx9PwKA+BaswfuNEb6V52KCtOC6/fc5lO6vhA
         Ab6pyuXDB/os4RmIuxi0dk4W08BQ4QwcW0K53zGLUCnAoDQVLEU4LznpAUpgwahrWhn7
         dqXBrq6i46Vk07Twq89puhugrR9mQ3iznytg3Q/z50m+Guo7zNSWx3dBAWRn5JpiI2QK
         XJTg==
X-Gm-Message-State: AGi0PuZMDRdVkQG74FNVH1rVhUr0QzMtICA/UrKe0jgoSufL2eTxlMyn
        QfNFTydaM34S/v0VzwtvAvSpkohhpzZgGt+94nYo+84JBJCJ5fk9DIMUrZRP3COmLZYV5nZLqHj
        3bWqnpaGiSZUoEiMu7CbZzQ==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr38056948wrq.63.1588161831807;
        Wed, 29 Apr 2020 05:03:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLf4KZ8Rngx22ZnSSPEeNNoZEwjNixMH7nATd8iA4vBWIWJ++JJzRvFnPP9z8By88bEDzPwkg==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr38056907wrq.63.1588161831501;
        Wed, 29 Apr 2020 05:03:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h16sm33279920wrw.36.2020.04.29.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:03:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com, pbonzini@redhat.com,
        tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com,
        peterx@redhat.com, thuth@redhat.com, chenhuacai@gmail.com
Subject: Re: [PATCH v4 1/7] KVM: s390: clean up redundant 'kvm_run' parameters
In-Reply-To: <20200427043514.16144-2-tianjia.zhang@linux.alibaba.com>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com> <20200427043514.16144-2-tianjia.zhang@linux.alibaba.com>
Date:   Wed, 29 Apr 2020 14:03:41 +0200
Message-ID: <87r1w6h52a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e335a7e5ead7..c0d94eaa00d7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4176,8 +4176,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  	return rc;
>  }
>  
> -static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
>  	struct runtime_instr_cb *riccb;
>  	struct gs_cb *gscb;
>  
> @@ -4243,8 +4244,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	/* SIE will load etoken directly from SDNX and therefore kvm_run */
>  }
>  
> -static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void sync_regs(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
>  		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
> @@ -4273,7 +4276,7 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  
>  	/* Sync fmt2 only data */
>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu))) {
> -		sync_regs_fmt2(vcpu, kvm_run);
> +		sync_regs_fmt2(vcpu);
>  	} else {
>  		/*
>  		 * In several places we have to modify our internal view to
> @@ -4292,8 +4295,10 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	kvm_run->kvm_dirty_regs = 0;
>  }
>  
> -static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void store_regs_fmt2(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	kvm_run->s.regs.todpr = vcpu->arch.sie_block->todpr;
>  	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
>  	kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
> @@ -4313,8 +4318,10 @@ static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	/* SIE will save etoken directly into SDNX and therefore kvm_run */
>  }
>  
> -static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void store_regs(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_run *kvm_run = vcpu->run;
> +
>  	kvm_run->psw_mask = vcpu->arch.sie_block->gpsw.mask;
>  	kvm_run->psw_addr = vcpu->arch.sie_block->gpsw.addr;
>  	kvm_run->s.regs.prefix = kvm_s390_get_prefix(vcpu);
> @@ -4333,7 +4340,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
>  	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
>  	if (likely(!kvm_s390_pv_cpu_is_protected(vcpu)))
> -		store_regs_fmt2(vcpu, kvm_run);
> +		store_regs_fmt2(vcpu);
>  }
>  
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> @@ -4371,7 +4378,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		goto out;
>  	}
>  
> -	sync_regs(vcpu, kvm_run);
> +	sync_regs(vcpu);
>  	enable_cpu_timer_accounting(vcpu);
>  
>  	might_fault();
> @@ -4393,7 +4400,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	}
>  
>  	disable_cpu_timer_accounting(vcpu);
> -	store_regs(vcpu, kvm_run);
> +	store_regs(vcpu);
>  
>  	kvm_sigset_deactivate(vcpu);

Haven't tried to compile this but the change itself looks obviously
correct, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

