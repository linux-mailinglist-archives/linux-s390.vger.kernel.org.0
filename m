Return-Path: <linux-s390+bounces-21551-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9r+KLyumR2qkcwAAu9opvQ
	(envelope-from <linux-s390+bounces-21551-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 14:08:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF270231A
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 14:08:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="LubTbo/+";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=CFytY+y6;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21551-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21551-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4053012C79
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04205348C7D;
	Fri,  3 Jul 2026 12:00:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3635836B
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 12:00:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080025; cv=none; b=O1kLTcv5tgzzj+a5voE7kckeLrgmYC15B9USKHI9uDZSNKF1YoR4FKW+MinqbK3fbmFRJhQbaOEHBI6dtCvIoUD+Vmj3eXor8p/+dgeoylSfIKa9M+YUreXdsP0XsQRdn++6WSjzRPj0iKwmZKMFxgA3GAHWSUqdpoeYSr3kGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080025; c=relaxed/simple;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQh+wfAIwXM+n+1P8tY9p1xxYzscVTB+AJisbASE+TzKgN+ambnltWtBZuT+tfheYBmZW7NhbslOSxrr4VqAUREkY7xRLXyI/s0B9RMfsho7or+nhQ8292QugDd0ATMAgN5oMixq+zY1Zcjl0YACPGiQyxOzdxl/QqAPtWdnfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LubTbo/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFytY+y6; arc=none smtp.client-ip=193.142.43.55
Date: Fri, 3 Jul 2026 14:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783080022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	b=LubTbo/+sGsgRDt0BMLAXB0AHUs1HO38dHCXG7I6SlcOUQ74HIIw2sjeTpooeCIZTT5M1Y
	VI3/m4iHRNBz+CJaJ5RtG0JxLXr/c+v6UcnLwkaKwg+Ye9MZ3qXs1zhw7UGxQPsX4pZ4tB
	ZhuHVGY6CSdg68fGjMoH5K8TUpOSmAVNPI/Sfk12+GCOcbBAzKkZHmS4aEOTLpSn70BtWI
	SqmpLGBiM8IztU28dpZ0CUFsZpxEwbEFl/8vnehFscRd9W04hCvVfk43k7/G/J9wkdNAr3
	Tvl08SgLcZO6bvtUi5NtMhh8qARgf97pr2yR1OMeULUzj72L0O0wyeE1dZvnZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783080022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxA8tM5dh3I3FMrLRqVtspMINUesL3110lPAu88ay6s=;
	b=CFytY+y66swUzhiLQdGFSgIfrBYxIHoqRHunU5UUuCcflzfV4iq+7ioJOAqMRAPKKRvzpp
	sbml7KLd6U+PccAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] s390/zcrypt: Delete CEX2 and CEX3 device drivers
Message-ID: <20260703120020.nXkZQZt-@linutronix.de>
References: <20260703100320.qvFoxNbp@linutronix.de>
 <28892518-5e79-4410-8cd1-1873da752818@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28892518-5e79-4410-8cd1-1873da752818@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21551-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dengler@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:freude@linux.ibm.com,m:hca@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06EF270231A

On 2026-07-03 13:39:15 [+0200], Holger Dengler wrote:
> Hi Sebastian,
Holger!

> Thanks for your patch, but we already got another series from Rongguang Wei
> [1], which has been already applied by Vasily.

Yesterday? After all these years I am off by a few days. Duh.

Sebastian

