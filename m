Return-Path: <linux-s390+bounces-17717-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKyAOf25vGnQ2QIAu9opvQ
	(envelope-from <linux-s390+bounces-17717-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:07:41 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C952D5568
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E83C4300B47E
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF02877FC;
	Fri, 20 Mar 2026 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dYdHcERt"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB714AD0D;
	Fri, 20 Mar 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976058; cv=none; b=CNThjlXA5+No3XKVeE+ebkOqarGwO1zbn/nh8xHnQIKQqsW3biImtfMoyRlF9M97jU+zrOHnEWrQRQ4eV297lDTxFUp6/Dfj6LISw9ZqqRFu75PJJbMUIvFz1OM/9wMHfgMcQZAaT9VpBkZGX83nKbaYaS7S2p/mRD26ldPQ4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976058; c=relaxed/simple;
	bh=3Ba4IepDA5JXl7/pM4/T4AAJpL/kPDrx9lZHCLRYSVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPypGt42x0f7y1may7l/T5Mp98rblMNuCEaduJMsPa7N1c/Srpdv7jfUAUApKxvdsEHEFNJbDrWN/XpqkVt72rV4Cow+XHzJxAopE1ln+sITqwW9B/C36tGjaSbr3CY+q1/kKNnRmFLZ1adGDU2AEdkOhEfx/B0hNO/ozP4yvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dYdHcERt; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976054; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+pDqs44dkcjEkb8OYJpU6L+/Zb+sncdVx4zheks3ZXc=;
	b=dYdHcERtYFyNDTA3+ZaSb0zhkINX++RF9JvBq39XHaTNKskbmntrB+vn38Plh0CJQ8M4rRNKMZ8wdWyajdB5G+jU77GwrnxHIAMTd7kNfr8ufDsZvm+VguuMIqoNLfEFry+kJX3yvWIW2gm66Tb8R7NKdA0PXdrRnjwoEZqzxl0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K9XTI_1773976052;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K9XTI_1773976052 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:07:33 +0800
Message-ID: <2ff1b860-ff76-48e6-98c5-28e517afd3f8@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:07:32 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm: change to return bool for
 pmdp_test_and_clear_young()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
 <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17717-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87C952D5568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/26 7:31 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:02AM +0800, Baolin Wang wrote:
>> Callers use pmdp_test_and_clear_young() to clear the young flag and check
>> whether it was set for this PMD entry. Change the return type to bool to
>> make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Some nits similar to before, otherwise LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks. And all comments acked.

