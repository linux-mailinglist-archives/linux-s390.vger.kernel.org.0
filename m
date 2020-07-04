Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7D2145CC
	for <lists+linux-s390@lfdr.de>; Sat,  4 Jul 2020 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGDMZh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 4 Jul 2020 08:25:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:56559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDMZh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 4 Jul 2020 08:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593865520;
        bh=hRnxg8DtT6k4/mZVelI77V7qFw+c66iSsZf/aODHFjk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CeMC7fyMBwu8ohSx+EQmLy69uXWkm8rVEDp0Pkf6yDpCRfGEmNJHEIHnwIvkeOF6W
         63vwfg5YmgMqG/lrvhl1lgvEtQ676a/UeMNtNtpbI5HcgJYAemH5eK57G31zqZvT3i
         FZlgqRc42e+u8x9hss9tY0nf6dFQoOWHilxSfgbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1kkD5y0iCk-00se4p; Sat, 04
 Jul 2020 14:25:20 +0200
Date:   Sat, 4 Jul 2020 14:25:17 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Message-ID: <20200704122517.GB3143@ubuntu>
References: <20200627125417.18887-1-oscar.carter@gmx.com>
 <202006270853.C40CA89806@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006270853.C40CA89806@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:yzZW78M2++DLSaE2wWY6qe0FnrDwLez6iHP7SSkTJBuSPNdWcNw
 2ASjko6NlqJ0ro0glT5/q08xba8c3/wk35ZI51qCBSm4IMuGGLzBGf/wYfejiafd04/bTwh
 X9P9ZTS5xf0ROWjtrIcQnnUyTt3srdkjZJQQY0DFzA0AAymjIROGGxjtY+B9CsalqQ7+L52
 NUXFNArqBNmh1L+13UAug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3hC62I/9p64=:UVoEGLBhNPIpOvgrjAdyjB
 3FgdbPiuCC3XvI7gXXjiBB1ql47XBRLqBpmTOrGoUD5gg7lzir18EJkaLRrWHvETyidwLKmyl
 I6lhhXnHI2/TEwziK/7rZ3gAzyVYjbNWfTGPUXzUoyqxASfJ1beYaSlovGrjm2dvwJOyQ6Z3R
 mvOZfrPFZXATPY+946oCF50nGxmLCIggHJhd8oW1dj9dsq57Y4q2cx/CXILd6FagwWHiQyqzh
 cffWWmtj6bI76gTOVfWGtGhZBvG9cLsLPw0IId5C2Tkhohy4CuAhVjimP80gwnepN/8bF4Mig
 rRRofCTaYPTaYOMjeKtkN+nbFYJkVfXZ5HT+aCwzLjbF1bkMk+DcqVVhBdoQaiXUm21jDPRWV
 i+mOwBKFiLpldSKrNJVeFia6PgGSGn4toE4+Zs3kvpKDERjzCmrwYfT5s2yHCn2N7e9Hnn/cj
 8shptfg+joterbJeTuCUXaOGeYTUupSM//SVjl9DvqqlcieNw08Hl4oiqr51Q2or0Lc4MqAXf
 od+Kckpy2Ombvjdq5uWTbciIJhaAqT8fMFifx5MFsKXVVdYR22pAFZXwXOUD2w5g6sgj4g1mX
 Hu3fLrlSK0jaQ7xnQoQe8fNaMWRNtzOl4KnqQTiSFPaWnkP6KC5GNeENK/eAqJGNNMtAnaChS
 GF/yuCafObo2L9+If/FxI0G1OEESlQX559BsHdFwhs5wVSAPJZEkMMhkqyTVZ7XGQn4j6Q8tY
 pIrn45Yps0e8dubBoLVroxyMb0OD/uG76TPCciwjWdKqdi/pClhRX7cUr35PTMNPtUs+k4c+j
 UMzh4jTVBy/qtTcD9GYSJcgJXCvG237Bu0X/mD5VjJNM7HF+z18yXW+DFEIwg35pCFeFaVwVX
 bQnUOAcgRgFaBbRFhmiqOskLRoMRKrwLP6T0GXvc5HIuQQi/5/wQO2Edw/MsHh+5LTOPdSAll
 1Go03clwMhDWoNY57I0Co1wthSz2ianZ5OzWZb2T4aJsH30Ewa6DCGRSDM/NwYCfpZ+Tk5NNh
 md4ffVC8xDS8AcLbTPsajmKCWQsBnjuejA4DHdoSSDa35TbB1soQhnoBS8z+0JRrE1LYNURHT
 zOl/jaHfAm+Ea0vvnBrw/gJIF0JFAakgUyHyvIx6wDPpLwm4dcNUSNuOUrF6+bnhrFJu1keqi
 zDMzFz7FNfZ/enBHhlo02sUrO0rxKLxEa837SUdySfl6HDKodvs8X1sNgkbHil9+UAdWO0Ann
 pCLGX/vTDjm6Ec2Xy
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Jun 27, 2020 at 09:10:56AM -0700, Kees Cook wrote:
> On Sat, Jun 27, 2020 at 02:54:17PM +0200, Oscar Carter wrote:
> > In an effort to enable -Wcast-function-type in the top-level Makefile =
to
> > support Control Flow Integrity builds, remove all the function callbac=
k
> > casts.
> >
> > To do this modify the function prototypes accordingly.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
>
> Oh yes, the tasklets! I'd love to see this fixed correctly. (Which is to
> say, modernize the API.) Romain hasn't had time to continue the work:
> https://lore.kernel.org/kernel-hardening/20190929163028.9665-1-romain.pe=
rier@gmail.com/
>
> Is this something you'd want to tackle?

Yes, of course. It will be a pleasure to work on this. But without forgett=
ing
the work to remove all the function cast mismatches.

> > ---
> >  drivers/s390/char/tty3270.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> > index 98d7fc152e32..aec996de44d9 100644
> > --- a/drivers/s390/char/tty3270.c
> > +++ b/drivers/s390/char/tty3270.c
> > @@ -556,8 +556,9 @@ tty3270_scroll_backward(struct kbd_data *kbd)
> >   * Pass input line to tty.
> >   */
> >  static void
> > -tty3270_read_tasklet(struct raw3270_request *rrq)
> > +tty3270_read_tasklet(unsigned long data)
> >  {
> > +	struct raw3270_request *rrq =3D (struct raw3270_request *)data;
>
> Regardless, this is correct as far as fixing the prototype.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Regards,
Oscar Carter
