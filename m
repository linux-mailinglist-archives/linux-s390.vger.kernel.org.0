Return-Path: <linux-s390+bounces-19247-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJuWMnB382mt4AEAu9opvQ
	(envelope-from <linux-s390+bounces-19247-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 17:38:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3CD4A4EB6
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2B330055C0
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F62D060D;
	Thu, 30 Apr 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjbXAGF+"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDF2DAFD7
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563165; cv=none; b=SeJdeAcn1Ya6oYHJ3EBUlVlBFxI/ugnnVDy1FhaNfp0W0TqoCSBsIYTp80MFm70Sx9HWKodKpz7I9uaEngNGinwU0rwZfWGOx7QAcGNc0ZQ/KlqMkRht3wwbLRNyIkbBH7h280vHjfr/V7XZ8stpwMp51Orenuuq7azUJWabPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563165; c=relaxed/simple;
	bh=agNcnRQM1KgflDt6xn/DOs3Lnq8oR25XzJJr+flipK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THjcSPatYTCt0Mhg/+ZJFUq7hDc5OzZ74PeNXh9VPJuPBD+H7xSr+pPUoAMIvdFGAOFiNuLOWJdhgx7uUt3r2+Viqyd2f3djef+o27AwGioF48FDJpYmxdqmc0gWYrhh93GVswYUuZn36StCxatK8lklFxScFSAapIWPFNUNl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjbXAGF+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so12235515e9.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777563162; x=1778167962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAMMBWlxuC5VTMg7XRzXOnsHoZnowd4Y/GYGwSPMbqE=;
        b=KjbXAGF+GRz7/6zyiZdgpaL3ynPtb+eo/SINBlvUlWB1U/WfQ18AAqtNewl9R9na6u
         K1hLr/YsTG5hAN6JWQeVvSvwKyAJqrK1Ltw/G35pwa2qemiKzlq1Bzya2XLRYEuknq0A
         CFg+ItLCxJs/dznGr1IhtZkcXJ1IdMvDiSxrSbrXblxjA47u8tF7gED1QvqNgFVtEfMH
         ++EDOKhSDUt/qoyOqQzZ7/aol5wbzTX+zCnYYOnrE3f+7+Nyt9VDSTJMUu4sjfGe1o0P
         /9qPKzKXCqwLWMc3fqvK2PzutKlFlQl2aWOlQDnOcHlfi+ZGx5wtLItqqUrrhoD35dRg
         U3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563162; x=1778167962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAMMBWlxuC5VTMg7XRzXOnsHoZnowd4Y/GYGwSPMbqE=;
        b=DUSFyJbV9x5IM88TSpdNLKvMLuMfuNMoK6Q5jFXp3bPSHOSHkuLQhnkianGTHlVXs/
         5U8LzfEy/z81SAhvSgSkk8wOfwVHaDWXnyEedVytYDc+t9oDl0GAC5BsAc15+v0Dtv4K
         acqtx84DLTgas4jmNamv0fKjs0wYGtu0qRiFJFae2RzEfPYWw7C8UolypZ58A2S01L6Y
         2rICxNEc1OEzvxPLDlQfmW6xNMdWJ0cg3aJBHIEEIIYMI/uuQJx7S7WLHPS22e6D5daE
         OoBLGseGrqSiYTp14YN6UEA04O8ZwKHDGQGLA3hs7C8hLXHJVMpUii3ifybcQD/Rl2wM
         Xzzg==
X-Forwarded-Encrypted: i=1; AFNElJ86JTMoi89+H+tX+zZ4qMD1ynmGYgCnmoQlZIMDQyqJbXEqs4AhDFncKUzjNC1YsX+a3uMeUpmLcLA0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GwGuA9zvTACqBOj23PX9PmQPxzQ3/J0ZgGvrvL2uhVIe4Y1s
	0XFdXsCYIUHt+H4o1gbv/nIq4PSXWQi9748ukg08sqn5pSR/gU9Cv4mWuen+ByM5CR0=
X-Gm-Gg: AeBDieug0r/04Dp5SjrQkqP64COgZvKXToB8Cy7mvbS+38heq9z3m3O/ONgex+HqHkv
	lqeac5LgM1E5Rwq2BEX6cVoa0G8wsJ+StDIvJZffZXWzWnFhPu/ZizCyZ9KkEgmbeo8CAoimsE8
	5hio5AJh2JXI8HntlJE4Afh4jxYYOzLIOXirmvOHzpo8CZRrH3lrEUi7976bE2clybVFUYO5aBk
	gVxx8Rf78M6x0t/qxKY7hQjm76yaKGW4Rj/G5L0dqvCpKw1FH8xWrN6bVliqMdp6u4zClHwmppd
	PGz9xOUldPcwKQ57gnAn/1uLys6IAa69caj6p8psFck6IeQtWvKOe2HJmZgEIn6+HmL3vBTsdJ2
	orrZgFNC9qyxlUanevkxMWd4epxD/YcT9oDn/EdzHRdZOkPSpH6VDcXMVWXmZELN1OxAyBmYOIz
	B/e/zMDglGtGDfMzyNfgnfymwGgpV+wwoBbX40WzzdMRsW2Si4VjMT4Accmw==
X-Received: by 2002:a05:600c:8b22:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48a84524e1dmr57699945e9.20.1777563162217;
        Thu, 30 Apr 2026 08:32:42 -0700 (PDT)
Received: from localhost (109-81-16-145.rct.o2.cz. [109.81.16.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm70429935e9.0.2026.04.30.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:32:41 -0700 (PDT)
Date: Thu, 30 Apr 2026 17:32:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afN2GBAjBSGlTgvA@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <20260430074305.9d3389ed71af040acfe222de@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430074305.9d3389ed71af040acfe222de@linux-foundation.org>
X-Rspamd-Queue-Id: 3F3CD4A4EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19247-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]

On Thu 30-04-26 07:43:05, Andrew Morton wrote:
> On Wed, 29 Apr 2026 14:13:59 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > prior to invocation. This separation introduces a scheduling race window
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> 
> Does process_mrelease() have a manpage?  My googling was a fail.

It does. Very well hidden in 884a7e5964e06
-- 
Michal Hocko
SUSE Labs

