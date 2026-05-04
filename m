Return-Path: <linux-s390+bounces-19338-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGAeOcCg+GkgxQIAu9opvQ
	(envelope-from <linux-s390+bounces-19338-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 04 May 2026 15:36:00 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5BD4BDF29
	for <lists+linux-s390@lfdr.de>; Mon, 04 May 2026 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52749301AD2A
	for <lists+linux-s390@lfdr.de>; Mon,  4 May 2026 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF813D7D72;
	Mon,  4 May 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnl6aPnS"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689B3D5642
	for <linux-s390@vger.kernel.org>; Mon,  4 May 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901752; cv=none; b=CtrXm5CorxfACSF2DK8KD7hdCzqIam/9EHVrU1F7QOxaIEpfJCxEmiWI9VjPhkLwXauzoyBSZNbByQafHiG8zPIAv4lW7AYzVTfBb0ZcqDHKAhCgt6SZ2erNjPUatZDe/yiHzFz6K9sTBMVRdRjydwGrhC5B6Qcey1yZoWdL2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901752; c=relaxed/simple;
	bh=anAXTn2WVNJfQBijdvlVjx89L+KjLxZQUrMBMBAvn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDfSVjw0CsTMSABwgjcM2ZhNydMgKALJ3lrBwExe5IdikiSjiiPiHOe0TBAVvEaNsqd5VkSUhouDiMO/hipEQoFjeevjlwXP0viQ+7AcoCgwVesOm8dF/Sz7hgIviH7Y76Mqq9mcKgaKEz2tfrm1AaMv8iO+AX3+6fSigvjvCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnl6aPnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B9C2BCC9
	for <linux-s390@vger.kernel.org>; Mon,  4 May 2026 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777901752;
	bh=anAXTn2WVNJfQBijdvlVjx89L+KjLxZQUrMBMBAvn58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lnl6aPnSMZ/pjCpEJwjG0toeC92lXw/P55HYyqxNMB6YvhxosGlsSkfcFGWIQdvph
	 v6DCKPOFaJdaIInkojOx3zd98rUeBZPsMfVjr1dpFdUHUwgtoGaBfhepHMXGqRIjo7
	 GS+m8HMV0rCgwsEGjGldTkNyxZ95+kWijuky3Pb8VRCdxbggS8Ars53lE+4Ke9qEPx
	 q53wkwHlT8njjjxNEJdSU4gvreF2UGiEDYXoEa8Zd37Z3D8Xbe52VT0+hznFzjq7zX
	 oo6aWDZLan5ELHWA6vU95lN5k+JdsM60zYAMO0KCtM8JoLRlq5CeZM0G7w0ENgzkrW
	 zQ/WSWIDKFSnA==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso4064096d6.3
        for <linux-s390@vger.kernel.org>; Mon, 04 May 2026 06:35:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ91lI3XSawOYvBVlmtZIlnPcnH0vjTJSrzPRgydjJNOLahhXd1HuLArc6AaoYcL67WBk44RZ+NMcv2E@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKPTJ+VY8PSdzQdVqhGMQ+Cb0kkRBmunVk/eGHP9VjkHaGiOq
	wpcu6OteupVAma+mUOocFC7jigLgLpTVLp+CGMwHUkujJ8u8806xpP5qaPXTL5idMxAfkw9jmGx
	reLCb8/NKSmN8/Vi90hnfGJz6eRDA/U8=
X-Received: by 2002:a05:6214:260a:b0:8ac:4fd1:2d4a with SMTP id
 6a1803df08f44-8b668a259e6mr167277966d6.33.1777901750649; Mon, 04 May 2026
 06:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
 <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com> <n5vsmp6ingbhfztl6wzcwmrz56gkkfbpzardk43scr7rcgqsw5@evtnov34c5bt>
In-Reply-To: <n5vsmp6ingbhfztl6wzcwmrz56gkkfbpzardk43scr7rcgqsw5@evtnov34c5bt>
From: Barry Song <baohua@kernel.org>
Date: Mon, 4 May 2026 21:35:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zBiRTttf1nR0Ni9BRT3Cv5XFZhyYP8oipFodpS7saGwQ@mail.gmail.com>
X-Gm-Features: AVHnY4I0u-Qbkg0vrggpRHSUVs_cQpUa3gydJwrEbvTBOzz3MxeuFlaWucVZXHg
Message-ID: <CAGsJ_4zBiRTttf1nR0Ni9BRT3Cv5XFZhyYP8oipFodpS7saGwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4A5BD4BDF29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19338-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,kvack.org,kernel.org,google.com,suse.com,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]

On Mon, May 4, 2026 at 9:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
[...]
>
> > > BTW I'm not sure I quite understand Barry's priority inversion proble=
m
> > > since I'd expect all threads of a task to generally be treated with t=
he
> > > same priority...
> >
> > Exactly not. Maybe these slides[2] and this project[3] can give
> > you a hint=E2=80=94they aim to standardize things on Linux by
> > learning from Apple OS. Basically, tasks are classified
> > into five types:
> >
> > USER_INTERACTIVE: Requires immediate response.
> > USER_INITIATED: Tolerates a short delay, but must respond quickly still=
.
> > UTILITY: Tolerates long delays, but not prolonged ones.
> > BACKGROUND: Doesn=E2=80=99t mind prolonged delays.
> > DEFAULT: System default behavior.
>
> Again, this is a clasification of tasks but not really of threads in a ta=
sk
> so at least for VMA lock there's no inversion so have?

I=E2=80=99m specifically referring to a task (i.e., a thread) when
discussing scheduler context. It may be clearer to use the
terms process and thread explicitly.

In a typical process sharing an mm_struct, each thread can
have a different priority.

In an Android app, some threads handle the UI and require
higher priority, such as the main thread and RenderThread;
otherwise, frame drops may occur.

The Linux scheduler can control scheduling policy and
priority for each thread.

Thanks
Barry

