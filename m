Return-Path: <linux-s390+bounces-1908-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554E485ADEA
	for <lists+linux-s390@lfdr.de>; Mon, 19 Feb 2024 22:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7E1C215D7
	for <lists+linux-s390@lfdr.de>; Mon, 19 Feb 2024 21:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432A5466C;
	Mon, 19 Feb 2024 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfVfn11z"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E753E32
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379036; cv=none; b=agj0tJK6y6C0w8AWRsYCzIluCVkylN4xHVjqmf9EkOpFRTcd6RkQGjXUFkIJ2ZNhpNNbPob38Wg6btjgUqqYyriWx+1VuM/Mbxw2y+8YxgeUugkvVORWXm4mwQWWUNtvTy5wc6PANZiXyJfCjA+jtwwtkGGGd/nf6ARU3uK/1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379036; c=relaxed/simple;
	bh=k6LH3b1KRcD8NJGil47OnFJ3hyweLeYZpxuRnYRLbos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEx+qlKFzjl5Qwm+nQtbytx0pYxUAtfx4bt+TJ55n8eah1LIvaGlaraIOGmjjSbgr3RPTlhwYStSfT+ylM3PQClHml+fj2AZCYs3unqBHA7foDscI+6p6boe+kd0Fhlh/9KS+HSLGgOmDREGJ0ynLhTN/eh4X7V1Kuc8cJESFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfVfn11z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso2611880276.1
        for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708379034; x=1708983834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIr2v00MmtLW5AiJLj4vFJLvOqk80nsA5VSLXwCEAuk=;
        b=VfVfn11zCkinb8Wzey0w02G6cMocpi+WxyrRxeIAkT2FuqO7M/aDfOBzKS8qI6Pj2+
         pG3HqDYfRvVTPKekkE/LCcfuZeC6ll2HUGdJQJs0bnknAMdUoLuGWzuCe/G4i5Hcyyrf
         NijeDmRRx+W9vF/X2+HHVdU/at6NkW44GnrCA+Rd1Xs53Xb87509LFeUBRKVz08U19qW
         CcywW3gU+Of9EPzcR+C6RG3BOpBk9bYQ8v/dEeAiiJY47zFgbkztr45rI3ZMNCUrr7gO
         hWWMtFL7lSGZS5w9xYdBfvWEUG6pfPk11Djgt6kVNzMsNC4rzGHMTguBSBiszBwufeVd
         bm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708379034; x=1708983834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIr2v00MmtLW5AiJLj4vFJLvOqk80nsA5VSLXwCEAuk=;
        b=no7VTyQLZ1ofV0RFxKXnsjiApC9+LzUVyVWSpxGCZtW1Nbo42O5W7rZ2cPiSYbnd1t
         Pv2HY3SfAoNRyef4mGjykTSzsdnBu7J5EbxXcyaPe1Guf25wdQCfkHRaMvD52TIbdk1E
         KcKckQci7px0dohs04vC5C9x2ZqA9tD86fw0EICaQApv+sVDiiGCJfbxWxul7HVgfyye
         sRNHId1HCSmld8HfTyCCekjuzS3DQzDbjdUB3oYOt7cDfqGSuY1ZPlkKlXmcumUWXqNb
         gw0qj+ygGk090nZ/wq+6asV3whOZvgHqetUyegj5YLIo4ApMmL2yrbP7twqvVax4ztsP
         PYYg==
X-Forwarded-Encrypted: i=1; AJvYcCWoehE5Y1j6XFIYecwsy5nfHSZVLNjRVOwXPzYay7wvFU2b1iw+6e0Z3KhxJm2ziq5vpF8b3+ajqeHmvU9gq8eYqa7qmni993E/Sg==
X-Gm-Message-State: AOJu0YzeDKdC2locFu8RSAcyYN18L2KlKPO73c8Mw0SqsaZQ1vDLTVMM
	ptH1Z6wUi93yiOdDL2XkgyPRM0e/7JAahnSs5m/rd5YCNZb12Ip5wT+Q/bQOrDeILcfPFsPwUeJ
	WfQ==
X-Google-Smtp-Source: AGHT+IH7o7oqW8IXOLQwhiL+D+fr+M7XPoB0mGCnvWQZj4Q5usQnlETlssOWLw0ZF0bnkI2bqi3OkZN/zQM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:705:b0:dc7:53a0:83ad with SMTP id
 k5-20020a056902070500b00dc753a083admr3628924ybt.5.1708379034234; Mon, 19 Feb
 2024 13:43:54 -0800 (PST)
Date: Mon, 19 Feb 2024 13:43:52 -0800
In-Reply-To: <20240215152916.1158-6-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215152916.1158-1-paul@xen.org> <20240215152916.1158-6-paul@xen.org>
Message-ID: <ZdPLmEeMhTaSiYrA@google.com>
Subject: Re: [PATCH v13 05/21] KVM: pfncache: remove KVM_GUEST_USES_PFN usage
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> As noted in [1] the KVM_GUEST_USES_PFN usage flag is never set by any
> callers of kvm_gpc_init(), which also makes the 'vcpu' argument redundant.

The changelog should explicitly call out that not only is KVM_GUEST_USES_PFN
unused, it's incomplete/broken (which is also partly why it's unused).  Without
that information, removing the support looks like a somewhat arbitrary decision,
versus a deliberate change to make it easier to support the gpc code.

