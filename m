Return-Path: <linux-s390+bounces-20683-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oYRAAwsdKGrS+AIAu9opvQ
	(envelope-from <linux-s390+bounces-20683-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:02:51 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE0660D20
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MrC54m7e;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20683-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20683-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7C03037ED8
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484484183C0;
	Tue,  9 Jun 2026 13:56:02 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB631E1DE5;
	Tue,  9 Jun 2026 13:56:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013362; cv=none; b=lAhAxdAnfLOYtlHjS9g8YURUckZUfMy4uH0p4RH+m21EHKtVTbl6KBW20INlsiWW1GXGelpsauy8SrqFlvxPPg+70lvonf6GRbvSW9dEzVzYQeD6bdbSBFpm9YZk9Dm4J2i1LcUTI+qqVzvR1Ke4BGG5VFJARDCyL9Yi9KjWBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013362; c=relaxed/simple;
	bh=1ArDJGDIm/6EtF9MOJN5eGVwYg4Y/oYySiTOgilaWss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZhy42CnFtQ/HK6g6jMlK/KCtusZHf1wG099cye84NQom2nh/syzq5nY9mlh7iwUmR/dqF3YU2RKczBDQHpLUcUXIjIrPQGSvdOaYzOoh8UpObWMc9pQAl158JchqWeIn63jHpm5NmkHvwOfxwWvcAOD9hfkFw9j/1NAvuZKhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrC54m7e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9EA1F00899;
	Tue,  9 Jun 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781013360;
	bh=oqTAZUeyCqqx5FAQ5sEAvNi2t9NKNHtG0Dkmr8SYqsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MrC54m7eXwIWdp6+tb3IREB0TH9VBm4VCus07EFbTq3pwF1OCNJVLH+WJDjXX0O6t
	 Z1fHo+fcc0nRu5C3oNMF0ZTJtYnrgzirnOpQJsNOzRYwS3hzYAE1Gc3sIKIMDiSb8/
	 VzeahdaAqhMq3Wh9hvb6G2yDElYpXorzzYpqeBKfg0U3SRO7ZJkeUTfDaM5rxa3pMz
	 iecRhWH1CjiHvIeT0BvW2giNs9qbafLWf10JdqzD2DlH2HJ2tWzCGZn+bI9jxxzAPu
	 XzyB8TcUZxNO+IwOkrFax+w9Jfmeo25mtNtuCtf8uA3rtGcHMZ0dB/rNm6TL97VnZx
	 mycd22tgnDcqQ==
Date: Tue, 9 Jun 2026 15:55:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: Idle time accounting improvements
Message-ID: <aigbbZW9gah401Y9@localhost.localdomain>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
 <20260608075500.34400A04-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608075500.34400A04-hca@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20683-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[frederic@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:tglx@kernel.org,m:peterz@infradead.org,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBBE0660D20

Le Mon, Jun 08, 2026 at 09:55:00AM +0200, Heiko Carstens a écrit :
> On Wed, May 13, 2026 at 04:01:25PM +0200, Heiko Carstens wrote:
> > This series is on top of Frederic Weisbecker's idle cpu time accounting
> > refactor series [1][2].
> > 
> > This is supposed to improve s390 idle time accounting, and brings it
> > back to the state it was before arch_cpu_idle_time() was removed from
> > s390 [3].
> > 
> > In result all cpu time accounting is done by the s390 architecture backend
> > again, instead of having a mix of architecure specific and common code
> > accounting (common code: idle, s390 architecture: everything else).
> 
> Thomas, Peter, Frederic, any objections to this series? The third patch
> touches common code, so I'd like to get an ACK for that.
> 
> If there is agreement, this could go either via tip tree's timers/nohz branch
> (series applies cleanly), or via s390, after the nohz branch has been merged
> upstream.

Looks all good to me, thanks!

Acked-by: Frederic Weisbecker <frederic@kernel.org>

I guess ideally it should go via s390. Any chance you can push this to this
merge window right after tip:timers/nohz is merged?

-- 
Frederic Weisbecker
SUSE Labs

