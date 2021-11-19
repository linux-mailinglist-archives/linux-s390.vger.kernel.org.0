Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246CD456E1B
	for <lists+linux-s390@lfdr.de>; Fri, 19 Nov 2021 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhKSLV2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Nov 2021 06:21:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSLV1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Nov 2021 06:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E77DF212CB;
        Fri, 19 Nov 2021 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637320704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ5zuSjieruVb8f7sgDLEBhctgmHBRj+VjClVUQZ8dY=;
        b=hCRfVvRGVD1MQxPEOD7yDF8/ryzSAAg8cFvCAW68MtLu+09W1IcQ+3N2FMWxa/yGwnxabr
        slgDuEeh9pPTnmE760c5sVzj+k1c4N1rwKa6SBf7Wn4WtVGjqH70Qu/RBgmcaSyyxsSSYP
        EvYvbnXY0Ftg/vN9jYo5e7Xd4ckPV+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637320704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ5zuSjieruVb8f7sgDLEBhctgmHBRj+VjClVUQZ8dY=;
        b=JKP4C5nucg8q8+Bp50NtlYcdqymg8x+HV16C7D4Bn7Nmod5SCZ1Tw1xCwBaxFrKa96YgMp
        8cSS/TdZoHEafsDA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A22F3A3B83;
        Fri, 19 Nov 2021 11:18:24 +0000 (UTC)
Date:   Fri, 19 Nov 2021 12:18:23 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com
Subject: Re: [PATCH 0/3] KEXEC_SIG with appended signature
Message-ID: <20211119111823.GC34414@kunlun.suse.cz>
References: <cover.1635948742.git.msuchanek@suse.de>
 <87czneeurr.fsf@dja-thinkpad.axtens.net>
 <20211105131401.GL11195@kunlun.suse.cz>
 <87a6ifehin.fsf@dja-thinkpad.axtens.net>
 <20211108120500.GO11195@kunlun.suse.cz>
 <56d2ae87-b9bf-c9fc-1395-db4769a424ea@linux.vnet.ibm.com>
 <20211112083055.GA34414@kunlun.suse.cz>
 <8cd90fea-05c9-b5f9-5e0c-84f98b2f55cd@linux.vnet.ibm.com>
 <20211116095343.GG34414@kunlun.suse.cz>
 <604dad24-5406-509c-d765-905d74880523@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604dad24-5406-509c-d765-905d74880523@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

On Thu, Nov 18, 2021 at 05:34:01PM -0500, Nayna wrote:
> 
> On 11/16/21 04:53, Michal Such�nek wrote:
> > On Mon, Nov 15, 2021 at 06:53:53PM -0500, Nayna wrote:
> > > On 11/12/21 03:30, Michal Such�nek wrote:
> > > > Hello,
> > > > 
> > > > On Thu, Nov 11, 2021 at 05:26:41PM -0500, Nayna wrote:
> > > > > On 11/8/21 07:05, Michal Such�nek wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > The other part is that distributions apply 'lockdown' patches that change
> > > > > > the security policy depending on secure boot status which were rejected
> > > > > > by upstream which only hook into the _SIG options, and not into the IMA_
> > > > > > options. Of course, I expect this to change when the IMA options are
> > > > > > universally available across architectures and the support picked up by
> > > > > > distributions.
> > > > > > 
> > > > > > Which brings the third point: IMA features vary across architectures,
> > > > > > and KEXEC_SIG is more common than IMA_KEXEC.
> > > > > > 
> > > > > > config/arm64/default:CONFIG_HAVE_IMA_KEXEC=y
> > > > > > config/ppc64le/default:CONFIG_HAVE_IMA_KEXEC=y
> > > > > > 
> > > > > > config/arm64/default:CONFIG_KEXEC_SIG=y
> > > > > > config/s390x/default:CONFIG_KEXEC_SIG=y
> > > > > > config/x86_64/default:CONFIG_KEXEC_SIG=y
> > > > > > 
> > > > > > KEXEC_SIG makes it much easier to get uniform features across
> > > > > > architectures.
> > > > > Architectures use KEXEC_SIG vs IMA_KEXEC based on their requirement.
> > > > > IMA_KEXEC is for the kernel images signed using sign-file (appended
> > > > > signatures, not PECOFF), provides measurement along with verification, and
> > > > That's certainly not the case. S390 uses appended signatures with
> > > > KEXEC_SIG, arm64 uses PECOFF with both KEXEC_SIG and IMA_KEXEC.
> > > Yes, S390 uses appended signature, but they also do not support
> > > measurements.
> > > 
> > > On the other hand for arm64/x86, PECOFF works only with KEXEC_SIG. Look at
> > > the KEXEC_IMAGE_VERIFY_SIG config dependencies in arch/arm64/Kconfig and
> > > KEXEC_BZIMAGE_VERIFY_SIG config dependencies in arch/x86/Kconfig. Now, if
> > > KEXEC_SIG is not enabled, then IMA appraisal policies are enforced if secure
> > > boot is enabled, refer to security/integrity/ima_efi.c . IMA would fail
> > > verification if kernel is not signed with module sig appended signatures or
> > > signature verification fails.
> > > 
> > > In short, IMA is used to enforce the existence of a policy if secure boot is
> > > enabled. If they don't support module sig appended signatures, by definition
> > > it fails. Thus PECOFF doesn't work with both KEXEC_SIG and IMA_KEXEC, but
> > > only with KEXEC_SIG.
> > Then IMA_KEXEC is a no-go. It is not supported on all architectures and
> > it principially cannot be supported because it does not support PECOFF
> > which is needed to boot the kernel on EFI platforms. To get feature
> > parity across architectures KEXEC_SIG is required.
> 
> I would not say "a no-go", it is based on user requirements.
> 
> The key takeaway from this discussion is that both KEXEC_SIG and IMA_KEXEC
> support functionality with some small degree of overlap, and that
> documenting the differences is needed.� This will help kernel consumers to
> understand the difference and enable the appropriate functionality for their
> environment.

Maybe I was not clear enough. If you happen to focus on an architecture
that supports IMA fully it's great.

My point of view is maintaining multiple architectures. Both end users
and people conecerend with security are rarely familiar with
architecture specifics. Portability of documentation and debugging
instructions across architectures is a concern.

IMA has large number of options with varying availablitily across
architectures for no apparent reason. The situation is complex and hard
to grasp.

In comparison the *_SIG options are widely available. The missing
support for KEXEC_SIG on POWER is trivial to add by cut&paste from s390.
With that all the documentation that exists already is also trivially
applicable to POWER. Any additional code cleanup is a bonus but not
really needed to enable the kexec lockdown on POWER.

Thanks

Michal
