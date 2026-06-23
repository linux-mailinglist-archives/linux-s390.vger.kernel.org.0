Return-Path: <linux-s390+bounces-21133-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cidXNK88OmoR4gcAu9opvQ
	(envelope-from <linux-s390+bounces-21133-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 09:58:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7566B50A5
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 09:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ockCs3Q+;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21133-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21133-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D467D3024E44
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46813C769D;
	Tue, 23 Jun 2026 07:58:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DF3C661A
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 07:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201517; cv=none; b=C7CQF+98a84DsjLkK/t9Ew8SM5uIKpXJsJquSlOM0tO1NeXpCGhQJV7Tx0oLebbpcODBO4dL2ItzsUkHmDqsgkPpgvr9SffF6GQr6hRExlRs1p2ot6FFDgLi09/hfn/b04np6ysQVgfiEqr2tHV6RhkT+63jeuXPMuBHBDYX3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201517; c=relaxed/simple;
	bh=khSZG1eYL9cJlphxXcESKKq9MlcJFe3CM8UDVhNeGyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dql88D2MGrQKp8JBEz0RYeSBS7+SMOTO8r7BAh7WBuu6yK9onBvtW3Gw0sFwe15DdSglgqyndrR9wQaPO8OWIUNZoBCj9XilPkucFgMJpzBCtVXMxSKQ98U85MwIyye5BLfEjS3AgUEy9OcrwfoCpzrohJRGDzjkQWnsb7jU8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ockCs3Q+; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8453bcf7276so2982329b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201516; x=1782806316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek6r0TkIKR0tiCQ28suwzM5bkNpctpIQyqr76NBcjWs=;
        b=ockCs3Q+aMA8uzhH5LD8cLCE6KXvf1EUrreZAYFBV3EZ3T5JPivJ3xpQZ/PlOZKsW2
         FVH8CWj7kmYanzIuxn13/NiQplJhWO0kTOB3mMMYjieqqW3syh/K3JPHJ4vTOOhIozNh
         3JTvZ4MWoK1I6coENEFiXhJShnNuW51Pbve4WeS1dB4fdewmWWrkLpizX7Cblv+DVjXp
         Q8/DKjSAcUKBZDQyz5s5LNmfvve2Tgg9h1yVnTiU0cmUVUZ9vTsor59jFzMFgWCPA/4V
         K04JyByV0Ilixe7t53EMfiCyrIDSPrQGXk/SiFMs3/KJaCXOXdgLKT2HS0wS6y2GIaAa
         iAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201516; x=1782806316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ek6r0TkIKR0tiCQ28suwzM5bkNpctpIQyqr76NBcjWs=;
        b=F9xrUS5N7u2uheCDqNSTtqEZF9SLhd4g8VQRUcy7gpLDGFFtmPVJF1k71cyah5wi2o
         Nq0ZX16mYECs6+gN+HvbdJ14vNlpu8z7mxD3gY8Fuqwmj12j0C6BkQkT9YLK5g0wXuE2
         gOC3vBI3qCK475Kgg8JWEvt4HLrHlKuboz7UJKr87eywhp/kxLIpLt3yfC8gz7kybcqu
         uNZjbw8x+Mb5e/wrVDr2O9zP1Ps+pOiKze+bxIpkGu3aOBPQbBaO4ZzgK0Mmu1PvtNRA
         IDcCjDiKdWjtFN7zisD/bWiFlFVAcFJmYSGiUisifc1tITKclLQjXUM3b9hS8gM/IR36
         myLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbemMyi3rUdoAOi2TXUQs02dPLvKQnGU7JDG6AbO7Ql+UESdlZY1WDRAniaSD/kYWg5hjCO7Sbj9eL@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4UCYM2JpqnS12FIrDVWoal0V4xdeMPDXgKAIGofCvljEGrkH
	rXAuej+y0EidLaWOOdOdtDcN31YzVbCh4lN71FmBOh+o+cqQNikNKmKq
X-Gm-Gg: AfdE7cl0DHrJTVMGBkMN63zNbx31w7Fj9A3nxPjCdJDMvz0LVcC7Cl1y5Olz9LNZUPR
	ryZb7pF63pN42sogt9UL9u+if/zxvKabf1VYbjMLQ3yD/CWTNyomb6Bu21rHriNOUGQQF1PSm7Z
	2ew1Z5bWlnJBtDqVOlFYmQiGAI5gmMAVYTLnEHcAbBmLmWZuXqDXMLIl0PQRtCu9C75oUzHnh6a
	F9Tu9bZKFHfsTaZa7DlMgt7OgGPuKT1Cd4/Dw7gveYQQimkUnlVvvzv4sQzR6jrJdFSB+4aO7L1
	/b3Xwu/5NuTIbu0kXeMRzHzF3U3nDtOve49FrqtbmiCbucgiNVq/7dbxc6K+4ugKLIgfMqzjJu1
	taD7e1kA1He2yEaGmhLKXxwihH7xKF6RKPSICZbsu1nWLdgfuzsZtaBCK0Q/XcgBgQBvd7Pm+7e
	859ZXkSpz33fyCbMKGKFbQ9tvWL0RxLIUZfGu007RF
X-Received: by 2002:a05:6a00:1707:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-84550900333mr19117203b3a.41.1782201515623;
        Tue, 23 Jun 2026 00:58:35 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:ede9:3e72:37cf:55a2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e745besm9355930b3a.28.2026.06.23.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:58:35 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chentao@kylinos.cn,
	chrisl@kernel.org,
	jack@suse.cz,
	kasong@tencent.com,
	kunwu.chan@gmail.com,
	liam@infradead.org,
	lianux.mm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	liyangouwen1@oppo.com,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	mhocko@suse.com,
	nphamcs@gmail.com,
	nzzhao@126.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	vbabka@kernel.org,
	wanglian@kylinos.cn,
	willy@infradead.org,
	youngjun.park@lge.com,
	zhanghongru06@gmail.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page fault performance
Date: Tue, 23 Jun 2026 15:58:05 +0800
Message-ID: <20260623075805.466317-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
References: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bhe@redhat.com,m:chentao@kylinos.cn,m:chrisl@kernel.org,m:jack@suse.cz,m:kasong@tencent.com,m:kunwu.chan@gmail.com,m:liam@infradead.org,m:lianux.mm@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:liyangouwen1@oppo.com,m:ljs@kernel.org,m:loongarch@lists.linux.dev,m:mhocko@suse.com,m:nphamcs@gmail.com,m:nzzhao@126.com,m:pfalcato@suse.de,m:rppt@kernel.org,m:shikemeng@huaweicloud.com,m:surenb@google.com,m:vbabka@kernel.org,m:wanglian@kylinos.cn,m:willy@infradead.org,m:youngjun.park@lge.com,m:zhanghongru06@gmail.com,m:kunwuchan@gmail.com,m:lianuxmm@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,kylinos.cn,suse.cz,tencent.com,gmail.com,infradead.org,lists.infradead.org,vger.kernel.org,kvack.org,lists.ozlabs.org,oppo.com,lists.linux.dev,suse.com,126.com,suse.de,huaweicloud.com,google.com,lge.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21133-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhanghongru06@gmail.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanghongru06@gmail.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,xiaomi.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F7566B50A5

> On 5/20/26 23:15, Matthew Wilcox wrote:=0D
> > On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:=0D
> >> My understanding is that we should not blame applications here. This i=
s 2026:=0D
> >> there are basically only two kinds of applications =E2=80=94 single-th=
readed and=0D
> >> multi-threaded =E2=80=94 and single-threaded applications are nearly e=
xtinct.=0D
> > =0D
> > all of the applications i run are either single threaded or don't fork.=
=0D
> > what multithreaded applications call fork?=0D
>=0D
> Traditionally the problem was random libraries using fork+execve to launc=
h other=0D
> programs ... instead of using alternatives like posix_spwan (some use cas=
es=0D
> require more work done before execve and cannot yet switch to that). I'd =
hope=0D
> that that is less of a problem on Android.=0D
>=0D
> I assume Android zygote might be multi threaded? Maybe sshd as well? Syst=
emd?=0D
> But I'd be surprised if there are really performance implications.=0D
>=0D
> Not sure about webbroswers .... I think most of them switched to fork ser=
vers,=0D
> where I would assume fork servers would be single-threaded.=0D
>=0D
> So, yeah, getting a clear understanding how this ends up being a problem =
on=0D
> Android would be great.=0D
=0D
Barry asked me to share observations on fork() usage across Android=0D
applications.=0D
=0D
I wrote a BPF-based tracing tool (kprobe on copy_process, checking=0D
CLONE_VM to distinguish process creation from thread creation) and ran=0D
it against the top 200 Android applications in the China market during=0D
normal usage scenarios.=0D
=0D
Results:=0D
- 82 out of 200 apps (41%) call fork() during normal operation=0D
- Among these, some call fork() from multiple threads=0D
=0D
These are not zygote forks =E2=80=94 they are fork() calls initiated by app=
=0D
threads at runtime. Examples by category:=0D
=0D
  Browsers:     com.quark.browser, com.UCMobile, com.xunlei.browser=0D
  Shopping:     com.taobao.taobao, com.tmall.wireless, com.achievo.vipshop=
=0D
  Video:        com.youku.phone, com.qiyi.video, com.hunantv.imgo.activity=
=0D
  Social/IM:    com.alibaba.android.rimet, com.ss.android.lark=0D
  News:         com.ss.android.article.news, com.ss.android.article.lite=0D
  Navigation:   com.autonavi.minimap, com.sdu.didi.psnger=0D
  Finance:      com.eg.android.AlipayGphone, com.chinamworld.main=0D
=0D
This confirms that fork() is widely used in real-world multi-threaded=0D
Android applications. Since dup_mmap() needs to acquire=0D
vma_start_write() for every VMA, holding the VMA lock across I/O=0D
would risk blocking fork() for unpredictable durations in these 82=0D
applications.=0D
=0D
Tracing tool (two equivalent implementations):=0D
  bpftrace:         https://gist.github.com/zhr250/bf4384202d598bb4cda71cb9=
902f15ab=0D
  libbpf-bootstrap: https://gist.github.com/zhr250/76189bdf51bdc8818500e4c8=
917c6493=0D
=0D
Analysis results (top 200 apps):=0D
  https://gist.github.com/zhr250/06f51092c84a49c602a55ac3d186e9ce=0D
=0D
Hongru=0D
=0D

