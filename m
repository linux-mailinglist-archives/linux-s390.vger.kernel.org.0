Return-Path: <linux-s390+bounces-19753-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG9dDA7OCmq18QQAu9opvQ
	(envelope-from <linux-s390+bounces-19753-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 10:30:06 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D54568C9A
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A9F13060FDA
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F903E7BAA;
	Mon, 18 May 2026 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWifYtBE"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FA3E4C83;
	Mon, 18 May 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092649; cv=none; b=c1UcEiE8qPsqKMKtW4rvyj1BiGNkwZqIcU+xBt5oF+UL3hCRhFhCpGsw+tmX6KOlZFWCT9f/bF8tSrvcBUN1SGBlKSSdT+KpTzm5d7LbjimxgnrZ57DU+Tfv8A0719Avya91rjN4626FT08NF9mtZy3fCgYGV8+mWbL5t719JZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092649; c=relaxed/simple;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrkCEhX1Qf2wieDzOXWogLT/gjv3tbW8UME//IQAnh9kUI49gUbryNhyZCyvbkla0muhUf8YPHQj5MSSzM1WUCi4I6zSRROfT3GgVGj1r13fOvsmAxCE94Sa0tk35i3QM+o8peZTXf3asNqPeyQklBprBTVfq8in1MgkzfiMr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWifYtBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D1C2BCB7;
	Mon, 18 May 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092649;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NWifYtBE4iioUAj3misRX6WwJ0qFse49SAbzHE90dFtNp8FN6knm3Yiph8G/VuQHI
	 mk5mZdPQEKJC66muMH1yh9b6HwWB0JlBDq+5eBGodIOS/8D1pPmfLOHdZOjeKWK88i
	 N/8w1A1QCWLgXVg9FtWIO/NYcHS1lK/vrQsa5fOdwGgM9OSoaJW4SZC9Hjn7WPYBcw
	 GeKO0qiVF65IovoAz/Xum8DtfjdWmTxiZ2CqAnKB3ZuqDWK9CLQYjpJrhBZDofIX5j
	 V9HjO3QpHnZq4b337FQLstpxcEkP7IBe0Bd8u8pcKxo9RJ8TS2P+8sg+7Whz3yPWao
	 yp6TgriAHH+hg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <agldl4XQLKAtyLty@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
Date: Mon, 18 May 2026 13:53:58 +0530
Message-ID: <yq5amrxxxh0h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 84D54568C9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19753-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Jiri Pirko <jiri@resnulli.us> writes:

> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>are handled consistently.
>>
>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>shared/decrypted buffer handling. This series consolidates the
>>force_dma_unencrypted() checks in the top-level functions and ensures
>>that the remaining DMA interfaces use DMA attributes to make the correct
>>decisions.
>
> FWIW, the patchset in general looks good to me. I tested this with my
> system_cc_shared dmabuf flow, works flawlessly.
>
> Thanks!
>
Thanks, Can I add

Tested-by: Jiri Pirko <jiri@resnulli.us>

-aneesh

