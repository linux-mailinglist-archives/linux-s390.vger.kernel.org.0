Return-Path: <linux-s390+bounces-19267-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO+NGJLm9GmxFgIAu9opvQ
	(envelope-from <linux-s390+bounces-19267-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 19:44:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C99404AE9D3
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B85713012BD7
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2026 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFAF31AABF;
	Fri,  1 May 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cokKUJ4c"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD96316197
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657487; cv=none; b=WAXpSE+XE5mQwMVw2qW55bKG4KE8ZuwaY8t2IW8GsBLEYLJbe1IH7QBhV+EFDV3+qtKD8HwUHheiGW85W2zvHiJ45e3huUVvUI08bPkNEcRXet9e2dZ9BQKHi+X1Kpt8AUeSpXu7LGw15D2Ut8b5/IXdjXgPFGaC8HwQC5oAOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657487; c=relaxed/simple;
	bh=Hl2YiWTcbo74Gxc6IpUU70j+aHuYqyHn+c9GqocmPS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF87mNdT+AKCTLPnVpCUB+ENWd4J1lo3lYeLc5KARNqtdOO3JELhX1sQSacvwbXVpfvk3fsp9V8vSWakXcjvzAe8Fp5sR2Eu6rmNTJINvzBicGqxWrG5P1CGs53eXBkET0zCZSZWyCCIxMX50MpcccmEtTB4yCMg1XxQRhvqsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cokKUJ4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C8DC2BD05
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657487;
	bh=Hl2YiWTcbo74Gxc6IpUU70j+aHuYqyHn+c9GqocmPS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cokKUJ4cVjTc6Fh+umuWaKXjfGu696YYSrhlsdu275noHQdipmmX0gkSiihTIc2Sl
	 fpYV1mlggK7Yc6cXYI+XurdET3PGISSUYmW2rPT5S58wxIfAaO5cGneYrdxbKBfIlB
	 XZEkY0bHXwj5IHxfWfRQxZg9bVbm6Czf+haANPTe/D+0YAlQo7B5g+S/t38bZMqyZA
	 Hvwafr5cJ0ewDjxPrc13qWWQ0oTeI8rTw7+kBgHhpYucb3owFD/0kIrKesBp3DFJve
	 SXoo+/ZlI3WZftzrouDPSabfXV4IkYxfnkLGV13yzz1iWbpLIbSY4Ytn/c7yT/Hw0B
	 9r576Ai8d9MRA==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b59772d441so6712246d6.0
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 10:44:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/4ocAtpmjTAKmLWjJSMQWFVdvMlOoaOpxSVkwkTJo+Qp6gXwRTqjydwZ5Lr//WRrpbYdkrlTR0jiKS@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQhpdWo5VVzgt8Tn6rgOPr3VckM3ytMtVFr7DHzLUy3dQ0QJJ
	2tVU4/tKaAFw9inxfmOJFY6eD7P4MaH6c/RHaN5Wcm6fD0YUrzx4c87PpTQ+VEoLalw9wmza9Q8
	TedzlT5aVXoVy7mT17+DgG97T6j48Sl4=
X-Received: by 2002:a05:6214:260a:b0:8ab:4ab9:bb50 with SMTP id
 6a1803df08f44-8b668638bfamr8385726d6.37.1777657486245; Fri, 01 May 2026
 10:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com> <afS_L-5XeWIldTXA@casper.infradead.org>
In-Reply-To: <afS_L-5XeWIldTXA@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 01:44:34 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
X-Gm-Features: AVHnY4L9r5jHmXxuaat24ga_fMfUkn2-2M0MEFhZDB6ITf6AdiWvpvcS2QZoKTw
Message-ID: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C99404AE9D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19267-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,kernel.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email]

On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > 1. There is no deterministic latency for I/O completion. It depends on
> > both the hardware and the software stack (bio/request queues and the
> > block scheduler). Sometimes the latency is short; at other times it can
> > be quite long. In such cases, a high-priority thread performing operati=
ons
> > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wai=
t
> > for an unpredictable amount of time.
>
> But does that actually happen?  I find it hard to believe that thread A
> unmaps a VMA while thread B is in the middle of taking a page fault in
> that same VMA.  mprotect() and madvise() are more likely to happen, but
> it still seems really unlikely to me.

It doesn=E2=80=99t have to involve unmapping or applying mprotect to
the entire VMA=E2=80=94just a portion of it is sufficient.

BTW, the chain can propagate: a page fault occurs, B wants to write this
VMA, and C (a higher-priority task) wants to write another VMA. D may need
to iterate VMAs under mmap_lock, so B can end up blocking both C and D.

