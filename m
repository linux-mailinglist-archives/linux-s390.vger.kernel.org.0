Return-Path: <linux-s390+bounces-20059-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDqTAe+nFWqJXAcAu9opvQ
	(envelope-from <linux-s390+bounces-20059-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 16:02:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D55D6FF8
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC38B30207F5
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD783F8EDA;
	Tue, 26 May 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwYysy/z"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F63290C8
	for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803779; cv=pass; b=QZ9XM1jhXJG0GULTcr2uuaH+kg0XNLHH6PiHgnWstnNedH1kZ3STe4BAguDZcKRnkQaIZqqFgibjZlXsM8DfRi4Jl16tiHwXDIVQi/tZ/Mf+0TZSmEXGnsemd8lkJd8emtrHwmSuvI6ZZtOCtuzUl7mgJc3AHJw2lduD5X6h+G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803779; c=relaxed/simple;
	bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVIHcPREawj2cVLnQ7BK2QCaD4UdPWqq6L9fzgzUT0p/ffoy9oDRguQtyqjCfRJfVQ107VONEO77PU/C2Ph7/NZ4hjfUfXvUDPKq3+e3s4IzB7jetFdcPqjb39dGm6ETxizE6IrEj5OkcQEJhQoQqT45Uo5X0nSJMUUMxQMn2Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwYysy/z; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3047a628b34so189636eec.3
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 06:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779803777; cv=none;
        d=google.com; s=arc-20240605;
        b=iHJWBfLXKVwGsgtrzbBpVVV2IfmZLY/hfiThdmzhjKpHIzdScXb0kx8xN0iZp7Ocu7
         ng8Tdeh7YDfOmWJTRsTcHj/P6aC0jTkvLohO5+KdxgzoDwLM+i5AnBPKQsan+l0OxBSP
         p6z3T2rAk880gUiwy5zBi8LmYGbvjunftY48g5zMfZVLAIanEcpJZc0mAUhSk6iSSoK4
         08l1qmGDnGtOi3jysxTaOKo2TOFhizpkGrRgM9UZej5IDDrimYjJoFe4kH1tNoDW4hLf
         fN4Ljverg43k+KO5artPR1j+0UQAZ49AhQjGS5ZJA1BVXse5H23Elrluy/SHWr74XZar
         5svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        fh=vpjSwgdoBsRrZjMnQ9SNjhUGIC2y6UpgYg/C9zsErdE=;
        b=gLBBOamobh1ro1IGXFwNF0UOSad03GdD+en0mS/ArYMjD6inbzEF1qpJczWjjRIl9p
         jYr8Y1DTQSAjKKNPpVrEn9m9e864UGMHOnh7fVW/MkVJrXTImhm3Fxr3KpP6Q3WRO2sH
         AjFwdri6ABHMsQp24DlpiMavJPn9bGrHPy3LJcQvje+pvz83PUX8JNIUgRxdcl0yMcW2
         1QpvUyI483YvsS993AJpReGm14NYrCOIo1regAIq/PP6gALDWM6HUnrUP8/aFG5sb0vc
         2J7B/TXmeWFzRG71DYQsBen63t0IJtBLmXpobgDAzCLnVUYsVDd9WD2Q705b5oRoqj7d
         l3lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803777; x=1780408577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        b=JwYysy/zZW16cAA1d+Q6PQjpg1nFFJck7fOT6sWcMa3peXLyaIuVUAuGgRt++oo7dE
         EEnLIf2KASXlAAy3ARVn7XCX1P1FAbRXws9p2sp3UA3wWsIYzBEOkaeV9hSAazlEJOxN
         YxctihhE5Cn5T1totMb4YKTYiifOcfebY10GHrTRg1LjX7k1B66elgXN2fUKXaw92bdD
         /UZLrlEHihHo5b9r9RMLnvQgrPF+bQt2vUmKGioZF0hfhh6AzT4IsXtw2aiHFZF1sRwk
         1yDmBzvBldObtT4slABoXN6h8V5nh6CN5LkZkYZaur9w3qZ1zkXq9NxrhazBN0bpwgaK
         T3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803777; x=1780408577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=skJ4pzip99V2f4F3f4qjF4oUEt+LEBVDzI//DWmgKL0=;
        b=sct/tk4zq/bDPXIXJRRYAkgqrwlnS+27SiHARVo+Q4lasgXEAM4ub2wcDsRZ/3aA21
         0fgkMpY0SfjYRHoV1fqUsqLQp5kD/j8EhZ8sqp+SdTYJULDJKGJKOJkJiV6NpISnTWFj
         D2sbG9MzI+hUc+2OO3LJGKnAjIdszfUZmYXU+fYlb+REUjVkmpPLcwSwUCdCJG4/p80t
         5aXAvsWdKkM6suPkiTLULjSCxrQ3FjxeMO5K/MMiSqvwnShM0mWtSsbwYJ++ba9jm6I8
         8NK8e/HHeRy95uIH/NrL8ohFL/LxY9+Ka3sNcvirJHkXjo/oMeCfZ0k2AJjY82p6auJr
         1NXw==
X-Forwarded-Encrypted: i=1; AFNElJ+GAv2pqfUQ8xOa+uOt5fSsbKYkNWrG65glTvRwWPF5JCUHmu/x3pA0ihqcfFfkFH9ivYWmEzoR1vZq@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDRmtV1WFKGDZgt/xikzfDivzt1S03NdQHfrjEbSClUd1t53N
	9m0PyxFB9Gax1yCAEhN4v08gXmlwOVgDLt5EviEGCSEpVWeNHuJd+Yk1VyDTT1SM4Yh0Nu05wiL
	DcAWBIlOlHQZOXQT5Uk9Bklxo7JefHKk=
X-Gm-Gg: Acq92OHtiirH0G6ycRLoEHi9up3QJAkmQg7hheLH0PD2yWDfe/KuG9CEW1/+QHG+qcP
	Xy0z7vHHi/4oNnmNA7x+DLhCU+mt3v8WxnQVow1uIBCT8wUY2zNX5yeHLPnIKRgqlztNKF+pinL
	hxR8D/ZahllUz+eNAZUfwf67tMmIslL23Ce+bV0lScXyrHFW+rPVMgVG4fYYVT516BUbZ9IzJ0X
	SyzIydAzoZsfoz3EDaJkmxKUnhbPbxyvuYPlN0TGfUoluMyn+Wt9cUHknjyZ8F00wK2tlEtgcJZ
	HROUVDJQMdkKjvOYzL20IrOdCLNQKlYygr2ytfX8yT3JUZxdg2B32iRDMImV6mt6jRNuH2GjVjN
	cwxDJnxhyIcxWgYQm1dK1Wt4=
X-Received: by 2002:a05:7301:3902:b0:304:5074:83b1 with SMTP id
 5a478bee46e88-3045074b479mr2538533eec.6.1779803777369; Tue, 26 May 2026
 06:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 15:55:49 +0200
X-Gm-Features: AVHnY4LOVakymX802QKrHkoiXHvzXTXbDu_OQa_QXhuIkwiTfggwGq-xBzN1E9c
Message-ID: <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20059-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,infradead.org,akamai.com,google.com,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E93D55D6FF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 7:03=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> s390 currently requires a rustc due to -Zpacked-stack, and the
> minimum tool version gating is adjusted accordingly.

This doesn't matter unless the maintainer applying this uses a merge
commit for the cover letter, but there is a missing word, and if the
word was meant to be "nightly", then the paragraph is likely outdated
anyway :)

Cheers,
Miguel

