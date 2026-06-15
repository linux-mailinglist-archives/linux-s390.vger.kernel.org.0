Return-Path: <linux-s390+bounces-20830-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yNkXLr3JL2qWGQUAu9opvQ
	(envelope-from <linux-s390+bounces-20830-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 11:45:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733C685287
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 11:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Zs9hM6fO;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20830-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20830-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5EA300EF63
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8A3DB319;
	Mon, 15 Jun 2026 09:43:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A72F7F0F;
	Mon, 15 Jun 2026 09:43:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516592; cv=none; b=rrVidZ90RK0TnLfWO0hpCHw+zBZ32Ps8VuY0SutvV1feMyPOIFKDDBVbzXNBe0T1V0UnfiwIT0O1uJOjELl83gjERs+js1sAgj38yCM9YQdF/FxYj6UnTeZbvXCzcJbSjCyydNN0O67GUuR8oVSpdb8rEJaFtQiHWSJUWWE+nNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516592; c=relaxed/simple;
	bh=8XApieO9CMG/CwMwUpjyrR+kXerIDGOvVokX3phbM4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcXSxWMbuDnXmBVTMDMEAMGeOnJBGfcyWSNNQRYUHzeqV9TdpyfqfbroW1cBzmKCS+ARvDUgcaxf5LTD5JnnHBpvIFUXcjOLSxiZaxcrNLjk/2WFzBltxRO3dGkmJAnjdrLOl3l5AQiSadg6+uoJ5+Gu8KmEvafo26MLP5oDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zs9hM6fO; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6M3rS1627170;
	Mon, 15 Jun 2026 09:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KHToBKPYp6tGPWLxhj5hxqWDiHEo1I
	/oYAYfFPdA0fs=; b=Zs9hM6fOYDWqEl170Vz9MUM7vg9LPsqNoQls4LjKu+gu8r
	cYSPkigYa675jPeluoJX1WcpgirPE517VUp+YG+7VQm7Fa23BDNoP0fyprkfF9UA
	nvoO1vhmzHiigQoxvBpYFyWqRpJP3N+0awFcuUGxSjLPwUGCnnQyQKceJk06XdnM
	++X+DhfAcropHZ42iicWQeadJ/j91qBd2w61XPE9ZSHI8IXyvY6NxRp2v5b/Ox/G
	U+J75T7NBxLxH9P11b7/bBxQovKtgqCExtExtnuaua+DbUwqXDYdgMEnGI5YvHE7
	igksri9kZJTNWbjj0vDNWNXkGSeWjWHu0LfKc0rw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efyemx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:43:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F9Ye6X001665;
	Mon, 15 Jun 2026 09:43:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjwxnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:43:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F9h2nO10027332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 09:43:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72ECE20040;
	Mon, 15 Jun 2026 09:43:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCCF020043;
	Mon, 15 Jun 2026 09:43:01 +0000 (GMT)
Received: from osiris (unknown [9.111.80.197])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 09:43:01 +0000 (GMT)
Date: Mon, 15 Jun 2026 11:43:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260615094300.31370D7a-hca@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
 <20260615091741.76724-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615091741.76724-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NyBTYWx0ZWRfX3ll0CNB+SjoV
 YScJty7fj7JS7PhAX3J4BhQfp5/RmYnjVZbqG+Pjj6i0kKtlYeIVQ9ZY0Tk+dXB1xIOEH6sk/iV
 /qoG3SmpUlVX/OOW0TzzQf9bGKMod+Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NyBTYWx0ZWRfX6m3Tek2oxkvZ
 qKRCxxZkx3Y+cZY82tWCFnBEwGQNW/LRntzkkA3elF9vfKGuMA2VauId4R85dW/aUU73VbdzTPZ
 tnA7zihPzj/j47KnR0/9erOQ9+lFuM9qe8LNrGDVKxNUGuniCg6yjURjlnjnsetIY0PMrsOwOqx
 0Em4SY0SKgzL8hRVEi5dGJgysdm2W/1OJLNt5AygjDrXseGW8CYXVij7Ed77cPMmkgxs3GzgLU3
 WNS6+pBqJN9uDayaFiE5NNsnCFS/mSdIy2iJmSLCEAkCxj8zgXFJYEMRYXnzcSqaS45Ffzrzy40
 sD0JgmuZks5VnTjdVZUWTrwHkwwO8m+3oelDbz9wS5jfmhWs0yl4AWLmn1TmD+PaC2jFz+wIWHX
 powcaVqDhNgSjslz1giVW0lMR/Ggqs6gKZr6O5g82tB2zx0EwLZMZFx76vz61b1S2gkqxbQaIuK
 yrUTzbuw08/msa77MzQ==
X-Proofpoint-GUID: cUqh2sNXJuzcvftcb3-wNwOmDCRd6mEW
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2fc92c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zylpksq2kIObO0u8B_EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cUqh2sNXJuzcvftcb3-wNwOmDCRd6mEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150097
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-20830-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1733C685287

On Mon, Jun 15, 2026 at 11:17:41AM +0200, Claudio Imbrenda wrote:
> The _PAGE_UNUSED softbit should not really be lying around. Its sole
> purpose is to signal to try_to_unmap_one() and try_to_migrate_one()
> that the page can be discarded instead of being moved / swapped.
> 
> KVM has no way to know why a page is being unmapped, so it sets the bit
> on userspace ptes corresponding to unused guest pages every time they
> get unmapped. KVM has no reasonable way to clear the bit once the page
> is in use again.
> 
> Without appropriate cleanup, the _PAGE_UNUSED bit will linger around
> and cause guest corruption when a used page is instead thrown out.
> 
> While set_ptes() checks and clears the bit, ptep_xchg_direct(),
> ptep_xchg_lazy(), and ptep_modify_prot_commit() did not. This led to
> used pages being thrown out as if they were unused, causing guest
> corruption.
> 
> This patch fixes the issue by introducing the missing checks in the
> above functions.
> 
> Also fix gmap_helper_try_set_pte_unused() to only set the bit if the
> pte is present; the _PAGE_UNUSED bit is only defined for present ptes
> and thus should not be set for non-present ptes.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: c98175b7917f ("KVM: s390: Add gmap_helper_set_unused()")
> ---
>  arch/s390/mm/gmap_helpers.c | 4 ++--
>  arch/s390/mm/pgtable.c      | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)

...

> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 4acd8b140c4b..2acc79383e7d 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -122,6 +122,8 @@ pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
>  
>  	preempt_disable();
>  	old = ptep_flush_direct(mm, addr, ptep, 1);
> +	if (pte_present(new))
> +		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));
>  	set_pte(ptep, new);
>  	preempt_enable();
>  	return old;
> @@ -160,6 +162,8 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
>  
>  	preempt_disable();
>  	old = ptep_flush_lazy(mm, addr, ptep, 1);
> +	if (pte_present(new))
> +		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));
>  	set_pte(ptep, new);
>  	preempt_enable();
>  	return old;
> @@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
>  void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t *ptep, pte_t old_pte, pte_t pte)
>  {
> +	if (pte_present(pte))
> +		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
>  	set_pte(ptep, pte);

Can't we move the logic from set_ptes() to set_pte() instead? The above
approach remembers me of the open-coded removal of the no-exec bit at many
places we had, which became a maintenance mess until it was rewritten.

The compiler _might_ even be clever enough to move the removal of the bit
outside the loop within set_ptes().

