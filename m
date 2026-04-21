Return-Path: <linux-s390+bounces-18921-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PxiCBI452no5QEAu9opvQ
	(envelope-from <linux-s390+bounces-18921-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 10:40:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DD43848F
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D06BA300CA03
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2026 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D539D6D9;
	Tue, 21 Apr 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m84g/SYw"
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726822AF1D;
	Tue, 21 Apr 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760844; cv=none; b=c72n9YaZ1rC0ca7zHQue0zcJmG/kh2116kUjupCGSGKazCVXPobhJRkDcAVxsUsACNedES5c0/XELA2Df7NCiRHjJiju+wJl6FIXGLQUofBSVg8QFOo+Kt5PUXsc14A3GdmeUDJp/jp6yGbYfrr0AR0sAi1aRQqgsxaL33KHzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760844; c=relaxed/simple;
	bh=EgumEJfrYaLcloTARpupOXQw32PxC3gb23jmLt56KT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOsxgmLM6E8VsD2Kil71qQsWQY4XC5QwulcxFSjxGfupCeI7tybgknTUfpomo6x1GuVJkJJaX9alQcdyGZ2UQKuAJSrp85Db7YmMBu3kfZyF6eCy02lwFfCAWvctBB9L5e1zMyst4E06ONmHdQjoVlD/DtLntbP5G/6KPCdQSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m84g/SYw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B260925E0;
	Tue, 21 Apr 2026 01:40:34 -0700 (PDT)
Received: from [10.57.63.119] (unknown [10.57.63.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD263F915;
	Tue, 21 Apr 2026 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776760840; bh=EgumEJfrYaLcloTARpupOXQw32PxC3gb23jmLt56KT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m84g/SYwoTZLaSaOqMPRRzbUY3MObVT2M729SpYBGr2MyrPKhYR9E74+K6sjJ0Vbw
	 LF/PIYYBuV86V7ZYmhOnDeRF75EDyFh53WYU+XEu+I/4m5IQOMasOzExjCvFK578q9
	 3wBS81X9Rm/vbkwxQAHT4CFnEaGGnv0jl9C3AWnA=
Message-ID: <566e7e6b-17be-426f-a3f1-a615d0d61077@arm.com>
Date: Tue, 21 Apr 2026 10:40:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mm: Make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <8809412aaed8a515fe2e149c822543d640060936.1776264097.git.agordeev@linux.ibm.com>
 <4dc47078-0f8b-4388-9715-744c18590a00@arm.com>
 <0dd3a5bf-a98b-4181-a88a-ec9c0203f90a-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <0dd3a5bf-a98b-4181-a88a-ec9c0203f90a-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18921-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 758DD43848F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/04/2026 06:57, Alexander Gordeev wrote:
>>> + * PTEs that fall within the specified range might observe update speedups.
>>> + * The PTE range must belong to the specified memory space and not cross
>>> + * a page table boundary.
>> Does that mean that all PTEs mapping [addr, end) must belong to the same
>> PTE page? I think the wording should be more specific.
> I tried to state that end of the range must not exceed pmd_addr_end(addr, end).
> Any of these sounds better?
>
> The PTE range must belong to the specified memory space and ...
> a) the address range must not cross the parent PMD address range boundary
> b) the PTEs must belong to the same parent PMD

I think b) is good, maybe "PMD entry" to be even clearer.  My previous
suggestion of talking about "PTE page" isn't ideal since some
architectures have page tables smaller (or larger) than a page.

- Kevin

