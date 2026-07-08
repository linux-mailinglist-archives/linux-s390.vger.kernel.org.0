Return-Path: <linux-s390+bounces-21793-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yxx6LiMrTmqsEQIAu9opvQ
	(envelope-from <linux-s390+bounces-21793-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 12:49:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A30DC7247B7
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 12:49:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Eok20oS+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21793-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21793-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC753012CFD
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABF42A7B6;
	Wed,  8 Jul 2026 10:43:07 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B64252B5;
	Wed,  8 Jul 2026 10:42:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507386; cv=none; b=KI+9fcC4BTCPEy3ZLxKSfs/+iZk37TmMVlMFRKX4RnVxQAZ21UU0Td+YtyXKRB7K3GIP4iNOuiAmHgxGCshI2M3qZwseEUeeLuxpZXNIpBXuPytrilh9uzdnth6cFdWxEPhOifkzZD7XhTMATzW+AfdOGA2KqNZY9P+igObiuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507386; c=relaxed/simple;
	bh=g1cEDVucPut9nx4DxUDgLwvwvEc+KFxNwPycj1pZ2/Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEgiYnJZ4OkVRFt9yOTiv+dulCvnVfuPdeUkUN746n2uD4v1IJmr3CVndZywLivPmtg2fOrM2ShWbEcBMpNdJZJ6bsDd8WgsEcPafFYoj672iRbkAH7Cpxuk2P04KVZ08XOBlIi0UXiyaqAkD8Gbp0K7sX197sMSAC/toZmZbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eok20oS+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29401F000E9;
	Wed,  8 Jul 2026 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507373;
	bh=l4UyoSNyXebLeXjulHaoflPQw9V3It1bzboWcTLzP7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eok20oS+ydCL9nQkOELYtvSANI3EO+8Mppguumlyf4qv4bE/mnNXLqjmaKSJLdLAz
	 e6wySYAdHbh0lv8vXonOiEQ1APKQGtVddR3qvacEXeqAGRcGA1Nr85Lgc3tF1lgoo2
	 bLF4lm+DuOFXrVmxvIDPZq/3uf3OfiMmil7FQwibynaZFTySQNWU4ZltrUHId1Jlf5
	 YsFeiJTQHvj3P9MVcPixYII7pO1Y15qOzHIniZGV/3SMGy3jCBCoW3GvxJ3JKpl6Bi
	 8IQwKmj/gDaHZCvwr6Vo2JjHZnC0Ya/9yiBQRw77Z5UBjQ53S4As7lVm39Rmv10X43
	 qSS3NqxqZ35vg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1whPju-00000002mQn-1Zh5;
	Wed, 08 Jul 2026 10:42:50 +0000
Date: Wed, 08 Jul 2026 11:44:37 +0100
Message-ID: <874ii97obu.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 25/27] KVM: s390: arm64: Implement vCPU IOCTLs
In-Reply-To: <20260706085229.979525-26-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
	<20260706085229.979525-26-seiden@linux.ibm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seiden@linux.ibm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, agordeev@linux.ibm.com, gra@linux.ibm.com, arnd@arndb.de, catalin.marinas@arm.com, borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org, fritz@linux.ibm.com, ggala@linux.ibm.com, hari55@linux.ibm.com, hca@linux.ibm.com, brueckner@linux.ibm.com, iii@linux.ibm.com, frankja@linux.ibm.com, joey.gouly@arm.com, nrb@linux.ibm.com, oss@nina.schoetterlglausch.eu, oupton@kernel.org, pbonzini@redhat.com, suzuki.poulose@arm.com, svens@linux.ibm.com, Ulrich.Weigand@de.ibm.com, gor@linux.ibm.com, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21793-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[maz@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gra@linux.ibm.com,m:arnd@arndb.de,m:catalin.marinas@arm.com,m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:fritz@linux.ibm.com,m:ggala@linux.ibm.com,m:hari55@linux.ibm.com,m:hca@linux.ibm.com,m:brueckner@linux.ibm.com,m:iii@linux.ibm.com,m:frankja@linux.ibm.com,m:joey.gouly@arm.com,m:nrb@linux.ibm.com,m:oss@nina.schoetterlglausch.eu,m:oupton@kernel.org,m:pbonzini@redhat.com,m:suzuki.poulose@arm.com,m:svens@linux.ibm.com,m:Ulrich.Weigand@de.ibm.com,m:gor@linux.ibm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A30DC7247B7

On Mon, 06 Jul 2026 09:52:25 +0100,
Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> +static void adjust_pc(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu_get_flag(vcpu, INCREMENT_PC)) {
> +		kvm_skip_instr(vcpu);
> +		vcpu_clear_flag(vcpu, INCREMENT_PC);
> +	}
> +}

Can you clarify the semantics of adjust_pc() here? arm64 also deals
with exceptions in the same code, and I wonder how you deal with this.

> +
> +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
> +
> +	adjust_pc(vcpu);
> +
> +	local_irq_disable();
> +	guest_enter_irqoff();
> +	local_irq_enable();
> +
> +	sae_block->icptr = 0;
> +
> +	sae64a(sae_block);
> +
> +	local_irq_disable();
> +	guest_exit_irqoff();
> +	local_irq_enable();
> +}
> +
> +/** kvm_arch_vcpu_ioctl_run() - run arm64 vCPU
> + *
> + * Execute arm64 guest instructions using SAE.
> + *
> + * Returns:
> + * 1 enter the guest (should not be observed by userspace)
> + * 0 exit to userspace
> + * < 0 exit to userspace, where the return value indicates n error
> + *
> + *
> + */
> +int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> +{
> +	DECLARE_KERNEL_FPU_ONSTACK32(fpu_save);
> +	struct kvm_run *kvm_run = vcpu->run;
> +	int ret;
> +
> +	if (kvm_run->exit_reason == KVM_EXIT_MMIO) {
> +		ret = kvm_handle_mmio_return(vcpu);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
> +	vcpu_load(vcpu);
> +
> +	kernel_fpu_begin(&fpu_save, KERNEL_FPC | KERNEL_VXR);
> +	load_vx_regs((vcpu->arch.ctxt.vregs));
> +
> +	if (!vcpu->wants_to_run) {
> +		ret = -EINTR;
> +		goto out;
> +	}
> +
> +	kvm_sigset_activate(vcpu);
> +
> +	might_fault();
> +
> +	ret = 1;
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason = KVM_EXIT_INTR;
> +			ret = -EINTR;
> +			continue;
> +		}
> +
> +		if (need_resched())
> +			schedule();
> +
> +		if (ret > 0)
> +			ret = check_vcpu_requests(vcpu);
> +
> +		vcpu->arch.sae_block.icptr = 0;
> +
> +		arm_vcpu_run(vcpu);
> +
> +		ret = handle_exit(vcpu);
> +
> +	} while (ret > 0);
> +
> +	kvm_sigset_deactivate(vcpu);
> +out:
> +	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
> +		adjust_pc(vcpu);

arm64 has the following statements:

	if (unlikely(vcpu_get_flag(vcpu, PENDING_EXCEPTION) ||
		     vcpu_get_flag(vcpu, INCREMENT_PC)))
		kvm_call_hyp(__kvm_adjust_pc, vcpu);

It isn't clear to me why you can afford not to deal with pending
exceptions when returning to userspace.

Thanks,

	M.

-- 
Jazz isn't dead. It just smells funny.

