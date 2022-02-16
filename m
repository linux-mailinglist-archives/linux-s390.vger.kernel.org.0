Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE244B8E15
	for <lists+linux-s390@lfdr.de>; Wed, 16 Feb 2022 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiBPQf3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Feb 2022 11:35:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBPQf2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Feb 2022 11:35:28 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCC1C25AE47;
        Wed, 16 Feb 2022 08:35:15 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9609A92009C; Wed, 16 Feb 2022 17:35:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8799192009B;
        Wed, 16 Feb 2022 16:35:14 +0000 (GMT)
Date:   Wed, 16 Feb 2022 16:35:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <Yg0YHHk7NVWjedgn@infradead.org>
Message-ID: <alpine.DEB.2.21.2202161631020.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk> <YgtQkjRe7fbXI/lS@infradead.org> <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk> <Yg0YHHk7NVWjedgn@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 16 Feb 2022, Christoph Hellwig wrote:

> > > Instead of adding generic-y just ad a mandatory-y in
> > > include/asm-generic/Kbuild.
> > 
> >  I'm inconvinced.  Not all archs want it, 5 don't.
> 
> Which is exactly what mandatory-y is for.  Provide the asm-generic
> version by default, but let architectures override it.

 I don't think so.  Those 5 architectures don't want it at all; 7 other 
ones have their own versions.

 Otherwise we could blanket-list all asm-generic headers as mandatory-y.

  Maciej
