Return-Path: <linux-s390+bounces-19778-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO8RMViBC2pvIgUAu9opvQ
	(envelope-from <linux-s390+bounces-19778-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 23:15:04 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E30573B2E
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78EF33007B15
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 21:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D08397695;
	Mon, 18 May 2026 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKnQHg2E"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DF396D36
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138898; cv=none; b=m0fhER6Sp1d7RIhr1qRCQy1byF2hfQl7jOUBOU6uCk1HtBCaZHLWT5y9LapREFmQbtCIoPZLyz/Zu8DjxIts88B3bhEhhNBDzTdWYDDyabzWc4zTeAJ0csyQRbMiFtr2jBO8vTcMz/T7elHP/c1RDbJ8yeVudJW9UQDnDQdY0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138898; c=relaxed/simple;
	bh=rs2uqTkIc7aAMCm9u6DZxVd5AsfHqGkk6OElJunpKgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hULHLravLqv0qOqeEqRmqI+rZ7m2ygvpKVSU1ajGUO8h9HHf7JS6ol1mHqf04DpLhS9pTO8njnyfgiMgfR4lORNozY9dFVIZWnVB0oT8LxYqO618TZSPEqTjs1Wk8iSm9N+bsJqub88SGs0vowLcc4uVemzSC4h/2j8Gp+Pm+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKnQHg2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517F8C2BD01
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 21:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779138898;
	bh=rs2uqTkIc7aAMCm9u6DZxVd5AsfHqGkk6OElJunpKgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LKnQHg2EuuoiFeAFnxbyqE2fDmZVEFfJR4ym+5yVJgFpQm71jto6sLdg5WZBmxtnG
	 feASvKZV1Hz5s2U3CIOgVNjCbMO2KjX0U8n0MqD5oIETyTM4cq2dp1kF8q1re74vLb
	 j2vE2OH/h90vuhLO9gHN2qcX8iyk6Gj1VD31+RAQ6EyTWZ4iOjRfdPPOVrvYcxkaZB
	 XBfLDuqUgKG5MGYNKIrR4nHOZTbtTfEwI8Yhu+ZJ5BbOAt8fRt2kA+h5FZmAtjQcpZ
	 rnFDFHuQ6kgr2W3lu3RNNXviIak6dJ8MP1UOPZWyzYJ4m9mWzT3WG+SsY25Gg+DtTb
	 3+Mm4p2TcK06g==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso556343241.2
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 14:14:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/xA58H0hEXpOiWdE8FK+34qsdTAR8hR70Si+xSeZq9dBPbFHSwkTAkVxw1svNFiEBVD2mahSlzajxp@vger.kernel.org
X-Gm-Message-State: AOJu0YyfC719mKaCAPlN3PY4DfDm1OO/llTxzjTTXi4kyZwY82mPCbWh
	h3U1dWtMMasR+MBub7RTAmGLR5iZzBlltxOZFnvRQZpT5L2XpIUctMjH+1kyBOVUoQCoYWtkw4d
	mI64PRdt8+HYr+Izvc4HvcI/M25SXNs0=
X-Received: by 2002:a67:e70a:0:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-63a3ee862bemr7850443137.19.1779138897435; Mon, 18 May 2026
 14:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
In-Reply-To: <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 05:14:45 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
X-Gm-Features: AVHnY4KjG65G1ecWJLmAXfyGgeXMxqs_Hs937nQXWNlaevhV7YwGMAI3sK3pWtE
Message-ID: <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19778-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,linux-foundation.org,kvack.org,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,126.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5E30573B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 3:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, May 18, 2026 at 4:26=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Mon, May 18, 2026 at 5:47=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
[...]
> >
> > I think we either need to fix `fork()`, or keep the current
> > behavior of dropping the VMA lock before performing I/O.
>
> I see. So, this problem arises from the fact that we are changing the
> pagefaults requiring I/O operation to hold VMA lock...
> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> any VMA modification. On the surface, that looks ok to me but I might
> be missing some corner cases. If nobody sees any obvious issues, I
> think it's worth a try.
>

Thanks. Besides the creation of processes via fork(), I
am also beginning to worry about the death of processes.

One thing that came to my mind this morning
is that when lowmemorykiller decides to kill an app, we
want the memory to be released as quickly as possible so
the new app or user scenario can get memory sooner.

In that case, if the app being killed is performing I/O
while holding the VMA lock, the unmapping procedure
could end up being blocked as well.

If we release the VMA lock as we currently do, we allow
process exit to proceed.

I haven't thought it through very clearly yet, and I
may be wrong. I'd like to do more investigation. I hope
the apps being killed stay very still, but who knows=E2=80=94we
have so many applications in the market.

Meanwhile, if you have any comments regarding the death
of processes, they would be very welcome.

Best Regards
Barry

