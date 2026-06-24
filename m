Return-Path: <linux-s390+bounces-21238-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ohBBz0MPGrMjAgAu9opvQ
	(envelope-from <linux-s390+bounces-21238-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 18:56:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFB6C0228
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 18:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=de72KRsf;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21238-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21238-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30B70300DECA
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8E33F580;
	Wed, 24 Jun 2026 16:56:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681233F582
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 16:56:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320186; cv=none; b=SvbehjppE3HYEzU1OD6hcS88TMKUA7Z+5XtNXD00jPczPDScwc9QjE+FxC8XT4jj80/H1/MVyM73/X4GU4FgUPqwPD4u72Gykf8sJLZTZfUxrPgRiJGNvJL1CdPJeDXbUDpPjvU0w+XwcRqGTNMhTGRqzNZGaCykwQe1crqMTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320186; c=relaxed/simple;
	bh=BipiAccr7F+j+FWSHhsP9dl4/USWUGTVIRwuK8noo/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meICfKomXVC+rwJ9FpE7DevXDRaxIa+TMg0TQ1Ml0aZmPxZVSz+6JqSD2QaZsj2Xz5ceencHsxTQU9NwBeu+H5WV55kCrL2nF60LHz1XF6buDbXJicmhTAm7q0fhtH2Y0GvNt5MxmbbcWps1IN99TmFq8F6MF80PKjZxw1Musu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de72KRsf; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782320184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uWd2bbBcB2YZaZKUkMdZJ6uyGJ0nov/KEbn0CWaj2xY=;
	b=de72KRsfCmaPKfu7BzrzbBXkht/F6517nYoOPZYiefr2900fuwVAKnoT5E9csVSGXq9d3T
	ZO/N0Z9CEb987FbTpNiotzZ79Q7PdyZOCL/6zwWLkgQuv8OWhDkLpmkRXSNTg3Iw2zglv7
	fQJcnvqR0PL+BqZWEX/sG7FGUAJpLdM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-PWRICioeNBWiEiu472Yb2A-1; Wed,
 24 Jun 2026 12:56:18 -0400
X-MC-Unique: PWRICioeNBWiEiu472Yb2A-1
X-Mimecast-MFC-AGG-ID: PWRICioeNBWiEiu472Yb2A_1782320177
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4EAD18005A1;
	Wed, 24 Jun 2026 16:56:17 +0000 (UTC)
Received: from [10.44.50.109] (unknown [10.44.50.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3165A3000235;
	Wed, 24 Jun 2026 16:56:15 +0000 (UTC)
Message-ID: <1fad4b9d-ca9b-4766-bbe0-46fd5a3d91ae@redhat.com>
Date: Wed, 24 Jun 2026 18:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v1 00/12] KVM: s390: Fix S390_USER_OPEREXEC and more
 gmap fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 borntraeger@de.ibm.com
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21238-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:frankja@linux.ibm.com,m:borntraeger@de.ibm.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pbonzini@redhat.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACFFB6C0228

On 6/24/26 13:19, Claudio Imbrenda wrote:
> Ciao Paolo,
> 
> here are some fixes for the second half of the merge window:
> 
> * Fix S390_USER_OPEREXEC so it can now be enabled regardless of other
>    unrelated capabilities
> * Fix handling of the _PAGE_UNUSED pte bit that could lead to guest
>    memory corruption in some scenarios
> * A bunch of misc gmap fixes (locking, behaviour under memory pressure)
> * Fix CMMA dirty tracking
> 
> The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:
> 
>    Linux 7.1 (2026-06-14 15:58:38 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-7.2-2
> 
> for you to fetch changes up to babe08404e1993697a523e60bc0f9d096ffe1ef8:
> 
>    KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits() (2026-06-24 10:08:57 +0200)

Looks like either you onboard kvm-s390 to sashiko, or just send patches 
to kvm@vger.kernel.org.

Anyhow I've pulled it, there's time to fix up things.

Paolo

> ----------------------------------------------------------------
> KVM: s390: Fix S390_USER_OPEREXEC and more gmap fixes
> 
> ----------------------------------------------------------------
> Claudio Imbrenda (9):
>        s390/mm: Fix handling of _PAGE_UNUSED pte bit
>        KVM: s390: Fix dat_peek_cmma() overflow
>        KVM: s390: Do not set special large pages dirty
>        KVM: s390: Fix code typo in gmap_protect_asce_top_level()
>        KVM: s390: Fix handle_{sske,pfmf} under memory pressure
>        KVM: s390: Fix locking in kvm_s390_set_mem_control()
>        KVM: s390: Fix cmma dirty tracking
>        KVM: s390: selftests: Fix cmma selftest
>        KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()
> 
> Eric Farman (3):
>        KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74
>        KVM: s390: selftests: Extended user_operexec tests
>        KVM: s390: Fix typo in UCONTROL documentation
> 
>   Documentation/virt/kvm/api.rst                     |   2 +-
>   arch/s390/include/asm/pgtable.h                    |   4 +-
>   arch/s390/kvm/dat.c                                |   5 +-
>   arch/s390/kvm/gmap.c                               |  35 +++++--
>   arch/s390/kvm/gmap.h                               |  12 ++-
>   arch/s390/kvm/kvm-s390.c                           |  71 ++++++++-----
>   arch/s390/kvm/priv.c                               |  10 +-
>   arch/s390/mm/gmap_helpers.c                        |   3 +-
>   .../testing/selftests/kvm/include/s390/facility.h  |   6 ++
>   tools/testing/selftests/kvm/s390/cmma_test.c       |   6 ++
>   tools/testing/selftests/kvm/s390/user_operexec.c   | 110 +++++++++++++++++++++
>   11 files changed, 226 insertions(+), 38 deletions(-)
> 


