Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEE71357
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jul 2019 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfGWHzE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 Jul 2019 03:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfGWHzE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jul 2019 03:55:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2182239E;
        Tue, 23 Jul 2019 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868503;
        bh=XTIupdkvBAk6FNP+2QR6xl7R06H8lbRCz3aQpx99k88=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=gRzxGwffi5Myg9zbZ3d4zuP153urc4STde0+DYmBrxGGYYu3dH/MCCkZmVFZNLbjg
         DfZ/IHRTqYRbpTxVJADxQCBr9Nw/q9h5RJ+GXBacveSkT8SOkyAup3lBVKZZs5LzBZ
         Yp7hRFDGbj4PcpzU6MgeNgF+DOmpLrkX+GwkJQ6s=
Date:   Tue, 23 Jul 2019 09:55:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jens Remus <jremus@linux.ibm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
Message-ID: <20190723075500.GA27243@kroah.com>
References: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
 <20190723073820.GU15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723073820.GU15868@phenom.ffwll.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 23, 2019 at 09:38:20AM +0200, Daniel Vetter wrote:
> Hi Greg,
> 
> Do you plan to pick this up in your console/vt/whatever-fixes branch?

Yes, now that the merge window is closed, I will be picking this up.

thanks,

greg k-h
