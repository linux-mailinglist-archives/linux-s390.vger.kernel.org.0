Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D619144763E
	for <lists+linux-s390@lfdr.de>; Sun,  7 Nov 2021 23:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhKGWVu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 7 Nov 2021 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhKGWVs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 7 Nov 2021 17:21:48 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2BC061570
        for <linux-s390@vger.kernel.org>; Sun,  7 Nov 2021 14:19:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m14so14239240pfc.9
        for <linux-s390@vger.kernel.org>; Sun, 07 Nov 2021 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vvhHrDlviXEtiu42f9Ed4TiIZsHPlHHchTgbcPhjOC4=;
        b=DKLtpSmbwJwijOvRDAEnE4ouv7I+PdkspcRptedwiQW+s7ock1jLZ//bfUU3KqVhBO
         bBQUAl9KcJ1Q6mAns3nLRjQIQf8hjG69ijlsXDi7sqJ5OokTU1fTXsCKgltrRRuLpfRp
         92fkj1s+7TZaU7a4cKiYGeze0dqq2qCOcVosc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vvhHrDlviXEtiu42f9Ed4TiIZsHPlHHchTgbcPhjOC4=;
        b=lsNbqc5bN0JLT3AAAhZRwiEYsTnuAGEDK0/hww04i/1GduFmq32oXb1ddJxsRYM3/E
         F/T3lR5nuwK9qmfl2hDF183yCiYITcjcR8GhE2kDl7XhxRhGrwCQi4IGgj2Lf5LCVWj9
         7I+K7W9efgKCUMrCB9fpnhExOmkBZfVQsF/yxlUTmSBesRj1gr2lKRWWPwYrWf56SQ0y
         SZJ9IbcOWJqB+yOxVT5XxshVa7zesf/4Byn9b8vcXVYtjbYdIHjcm++430TQtAotMKGt
         3wRb4c/dlgTrzl1aoS88PyVCVLV2hubwEfs5KKTiMX4ZOlLOrQVu9vz2yF6xDlC4b4tK
         m/pw==
X-Gm-Message-State: AOAM533FpRFNzLFqLh6QVp7W7PJMcgDSg1VMJY2ZqHzVHXNrujGONLlc
        6TTVoBa1Pvx6kUYj3R4RBFXIAg==
X-Google-Smtp-Source: ABdhPJxfFXdXIw4YX3AftpaKpLmcq1g8ANa0foPZPl3tIwJBZSTL0sL86tkEOb1z5QnEzVlr5Hl6Bw==
X-Received: by 2002:a05:6a00:8c4:b0:44c:9827:16cc with SMTP id s4-20020a056a0008c400b0044c982716ccmr76290901pfu.7.1636323540309;
        Sun, 07 Nov 2021 14:19:00 -0800 (PST)
Received: from localhost ([2001:4479:e000:e400:9243:f22c:33ee:c8cf])
        by smtp.gmail.com with ESMTPSA id d17sm13127106pfo.40.2021.11.07.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 14:18:59 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
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
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 0/3] KEXEC_SIG with appended signature
In-Reply-To: <20211105131401.GL11195@kunlun.suse.cz>
References: <cover.1635948742.git.msuchanek@suse.de>
 <87czneeurr.fsf@dja-thinkpad.axtens.net>
 <20211105131401.GL11195@kunlun.suse.cz>
Date:   Mon, 08 Nov 2021 09:18:56 +1100
Message-ID: <87a6ifehin.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Fri, Nov 05, 2021 at 09:55:52PM +1100, Daniel Axtens wrote:
>> Michal Suchanek <msuchanek@suse.de> writes:
>>=20
>> > S390 uses appended signature for kernel but implements the check
>> > separately from module loader.
>> >
>> > Support for secure boot on powerpc with appended signature is planned -
>> > grub patches submitted upstream but not yet merged.
>>=20
>> Power Non-Virtualised / OpenPower already supports secure boot via kexec
>> with signature verification via IMA. I think you have now sent a
>> follow-up series that merges some of the IMA implementation, I just
>> wanted to make sure it was clear that we actually already have support
>
> So is IMA_KEXEC and KEXEC_SIG redundant?
>
> I see some architectures have both. I also see there is a lot of overlap
> between the IMA framework and the KEXEC_SIG and MODULE_SIg.


Mimi would be much better placed than me to answer this.

The limits of my knowledge are basically that signature verification for
modules and kexec kernels can be enforced by IMA policies.

For example a secure booted powerpc kernel with module support will have
the following IMA policy set at the arch level:

"appraise func=3DKEXEC_KERNEL_CHECK appraise_flag=3Dcheck_blacklist apprais=
e_type=3Dimasig|modsig",
(in arch/powerpc/kernel/ima_arch.c)

Module signature enforcement can be set with either IMA (policy like
"appraise func=3DMODULE_CHECK appraise_flag=3Dcheck_blacklist appraise_type=
=3Dimasig|modsig" )
or with CONFIG_MODULE_SIG_FORCE/module.sig_enforce=3D1.

Sometimes this leads to arguably unexpected interactions - for example
commit fa4f3f56ccd2 ("powerpc/ima: Fix secure boot rules in ima arch
policy"), so it might be interesting to see if we can make things easier
to understand.  I suspect another amusing interaction is that if the IMA
verification is used, the signature could be in an xattr rather than an
appended signature.

Kind regards,
Daniel

