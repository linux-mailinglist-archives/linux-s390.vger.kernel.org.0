Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20D7261A94
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIHSgp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 14:36:45 -0400
Received: from verein.lst.de ([213.95.11.211]:53228 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731349AbgIHQJN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EEA7468AFE; Tue,  8 Sep 2020 14:28:42 +0200 (CEST)
Date:   Tue, 8 Sep 2020 14:28:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: set_fs removal for s390
Message-ID: <20200908122842.GA32336@lst.de>
References: <20200908063133.GA14217@lst.de> <20200908122637.GB14136@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908122637.GB14136@osiris>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 08, 2020 at 02:26:37PM +0200, Heiko Carstens wrote:
> >  (2) implement the __get_user_nofault and __put_user_nofault helpers to
> >      safely access kernel memory.  These should behave like
> >      get_user/put_user under set_fs(KERNEL_DS), but not actually
> >      manipulate any task state to do so
> >  (3) unselect CONFIG_SET_FS and remove all the code related to overriding
> >      the address space(3) unselect CONFIG_SET_FS and remove all the code
> >      related to overriding the address space limit
> 
> Ok, I guess everything will have to land in vfs.git then.

The branch is supposed to be a stable base that you can pull into
your tree.
